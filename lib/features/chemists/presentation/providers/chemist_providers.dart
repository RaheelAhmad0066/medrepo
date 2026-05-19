import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/features/chemists/data/datasources/chemist_remote_datasource.dart';
import 'package:medrep_pro/features/chemists/data/datasources/chemist_local_datasource.dart';
import 'package:medrep_pro/features/chemists/data/repositories/chemist_repository_impl.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';
import 'package:medrep_pro/features/chemists/domain/repositories/chemist_repository.dart';

final chemistRemoteDataSourceProvider = Provider<ChemistRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return ChemistRemoteDataSource(dio);
});

final chemistLocalDataSourceProvider = Provider<ChemistLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ChemistLocalDataSource(db);
});

final chemistRepositoryProvider = Provider<ChemistRepository>((ref) {
  final remote = ref.watch(chemistRemoteDataSourceProvider);
  final local = ref.watch(chemistLocalDataSourceProvider);
  final conn = ref.watch(connectivityProvider);
  final db = ref.watch(appDatabaseProvider);
  return ChemistRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
    connectivityService: conn,
    db: db,
  );
});

class ChemistListState {
  final List<Chemist> chemists;
  final bool isLoading;
  final String? error;
  final int page;
  final bool hasReachedMax;
  final String searchQuery;
  final String? selectedPriority;

  ChemistListState({
    required this.chemists,
    required this.isLoading,
    this.error,
    required this.page,
    required this.hasReachedMax,
    required this.searchQuery,
    this.selectedPriority,
  });

  factory ChemistListState.initial() => ChemistListState(
        chemists: [],
        isLoading: false,
        page: 1,
        hasReachedMax: false,
        searchQuery: '',
      );

  ChemistListState copyWith({
    List<Chemist>? chemists,
    bool? isLoading,
    String? error,
    int? page,
    bool? hasReachedMax,
    String? searchQuery,
    String? selectedPriority,
    bool clearPriority = false,
  }) {
    return ChemistListState(
      chemists: chemists ?? this.chemists,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPriority: clearPriority ? null : (selectedPriority ?? this.selectedPriority),
    );
  }
}

class ChemistListNotifier extends StateNotifier<ChemistListState> {
  final ChemistRepository _repository;

  ChemistListNotifier(this._repository) : super(ChemistListState.initial()) {
    fetchChemists();
  }

  Future<void> fetchChemists({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (forceRefresh) {
      state = state.copyWith(page: 1, hasReachedMax: false, chemists: []);
    }

    if (state.hasReachedMax) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getChemists(
      page: state.page,
      limit: 15,
      searchQuery: state.searchQuery,
      priorityTag: state.selectedPriority,
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (newChemists) {
        state = state.copyWith(
          isLoading: false,
          chemists: [...state.chemists, ...newChemists],
          page: state.page + 1,
          hasReachedMax: newChemists.length < 15,
        );
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
    );
  }

  void setSearchQuery(String query) {
    if (state.searchQuery == query) return;
    state = state.copyWith(searchQuery: query);
    fetchChemists(forceRefresh: true);
  }

  void setPriorityFilter(String? priority) {
    if (state.selectedPriority == priority) return;
    if (priority == null) {
      state = state.copyWith(clearPriority: true);
    } else {
      state = state.copyWith(selectedPriority: priority);
    }
    fetchChemists(forceRefresh: true);
  }

  Future<void> addChemist(Chemist chemist) async {
    final result = await _repository.addChemist(chemist);
    result.when(
      onSuccess: (newChemist) {
        state = state.copyWith(
          chemists: [newChemist, ...state.chemists],
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> updateChemist(Chemist chemist) async {
    final result = await _repository.updateChemist(chemist);
    result.when(
      onSuccess: (updatedChemist) {
        state = state.copyWith(
          chemists: state.chemists.map((e) => e.id == updatedChemist.id ? updatedChemist : e).toList(),
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> deleteChemist(String chemistId) async {
    final result = await _repository.deleteChemist(chemistId);
    result.when(
      onSuccess: (_) {
        state = state.copyWith(
          chemists: state.chemists.where((e) => e.id != chemistId).toList(),
        );
      },
      onFailure: (_) {},
    );
  }
}

final chemistListProvider = StateNotifierProvider<ChemistListNotifier, ChemistListState>((ref) {
  final repo = ref.watch(chemistRepositoryProvider);
  return ChemistListNotifier(repo);
});
