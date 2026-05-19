import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/features/doctors/data/datasources/doctor_remote_datasource.dart';
import 'package:medrep_pro/features/doctors/data/datasources/doctor_local_datasource.dart';
import 'package:medrep_pro/features/doctors/data/repositories/doctor_repository_impl.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';
import 'package:medrep_pro/features/doctors/domain/repositories/doctor_repository.dart';

final doctorRemoteDataSourceProvider = Provider<DoctorRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return DoctorRemoteDataSource(dio);
});

final doctorLocalDataSourceProvider = Provider<DoctorLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DoctorLocalDataSource(db);
});

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) {
  final remote = ref.watch(doctorRemoteDataSourceProvider);
  final local = ref.watch(doctorLocalDataSourceProvider);
  final conn = ref.watch(connectivityProvider);
  final db = ref.watch(appDatabaseProvider);
  return DoctorRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
    connectivityService: conn,
    db: db,
  );
});

class DoctorListState {
  final List<Doctor> doctors;
  final bool isLoading;
  final String? error;
  final int page;
  final bool hasReachedMax;
  final String searchQuery;
  final String? selectedTier;

  DoctorListState({
    required this.doctors,
    required this.isLoading,
    this.error,
    required this.page,
    required this.hasReachedMax,
    required this.searchQuery,
    this.selectedTier,
  });

  factory DoctorListState.initial() => DoctorListState(
        doctors: [],
        isLoading: false,
        page: 1,
        hasReachedMax: false,
        searchQuery: '',
      );

  DoctorListState copyWith({
    List<Doctor>? doctors,
    bool? isLoading,
    String? error,
    int? page,
    bool? hasReachedMax,
    String? searchQuery,
    String? selectedTier,
    bool clearTier = false,
  }) {
    return DoctorListState(
      doctors: doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTier: clearTier ? null : (selectedTier ?? this.selectedTier),
    );
  }
}

class DoctorListNotifier extends StateNotifier<DoctorListState> {
  final DoctorRepository _repository;

  DoctorListNotifier(this._repository) : super(DoctorListState.initial()) {
    fetchDoctors();
  }

  Future<void> fetchDoctors({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (forceRefresh) {
      state = state.copyWith(page: 1, hasReachedMax: false, doctors: []);
    }

    if (state.hasReachedMax) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getDoctors(
      page: state.page,
      limit: 15,
      searchQuery: state.searchQuery,
      tier: state.selectedTier,
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (newDoctors) {
        state = state.copyWith(
          isLoading: false,
          doctors: [...state.doctors, ...newDoctors],
          page: state.page + 1,
          hasReachedMax: newDoctors.length < 15,
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
    fetchDoctors(forceRefresh: true);
  }

  void setTierFilter(String? tier) {
    if (state.selectedTier == tier) return;
    if (tier == null) {
      state = state.copyWith(clearTier: true);
    } else {
      state = state.copyWith(selectedTier: tier);
    }
    fetchDoctors(forceRefresh: true);
  }

  Future<void> addDoctor(Doctor doctor) async {
    final result = await _repository.addDoctor(doctor);
    result.when(
      onSuccess: (newDoctor) {
        state = state.copyWith(
          doctors: [newDoctor, ...state.doctors],
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> updateDoctor(Doctor doctor) async {
    final result = await _repository.updateDoctor(doctor);
    result.when(
      onSuccess: (updatedDoctor) {
        state = state.copyWith(
          doctors: state.doctors.map((e) => e.id == updatedDoctor.id ? updatedDoctor : e).toList(),
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> deleteDoctor(String doctorId) async {
    final result = await _repository.deleteDoctor(doctorId);
    result.when(
      onSuccess: (_) {
        state = state.copyWith(
          doctors: state.doctors.where((e) => e.id != doctorId).toList(),
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> mockImportExcel(List<Doctor> importedList) async {
    await _repository.importDoctorsFromExcel(importedList);
    fetchDoctors(forceRefresh: true);
  }
}

final doctorListProvider = StateNotifierProvider<DoctorListNotifier, DoctorListState>((ref) {
  final repo = ref.watch(doctorRepositoryProvider);
  return DoctorListNotifier(repo);
});
