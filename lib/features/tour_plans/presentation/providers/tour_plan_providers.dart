import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/features/tour_plans/data/datasources/tour_plan_remote_datasource.dart';
import 'package:medrep_pro/features/tour_plans/data/datasources/tour_plan_local_datasource.dart';
import 'package:medrep_pro/features/tour_plans/data/repositories/tour_plan_repository_impl.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/domain/repositories/tour_plan_repository.dart';

final tourPlanRemoteDataSourceProvider = Provider<TourPlanRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return TourPlanRemoteDataSource(dio);
});

final tourPlanLocalDataSourceProvider = Provider<TourPlanLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TourPlanLocalDataSource(db);
});

final tourPlanRepositoryProvider = Provider<TourPlanRepository>((ref) {
  final remote = ref.watch(tourPlanRemoteDataSourceProvider);
  final local = ref.watch(tourPlanLocalDataSourceProvider);
  final conn = ref.watch(connectivityProvider);
  final db = ref.watch(appDatabaseProvider);
  return TourPlanRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
    connectivityService: conn,
    db: db,
  );
});

class TourPlanState {
  final List<TourPlan> plans;
  final bool isLoading;
  final String? error;

  TourPlanState({
    required this.plans,
    required this.isLoading,
    this.error,
  });

  factory TourPlanState.initial() => TourPlanState(plans: [], isLoading: false);

  TourPlanState copyWith({
    List<TourPlan>? plans,
    bool? isLoading,
    String? error,
  }) {
    return TourPlanState(
      plans: plans ?? this.plans,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TourPlanNotifier extends StateNotifier<TourPlanState> {
  final TourPlanRepository _repository;

  TourPlanNotifier(this._repository) : super(TourPlanState.initial()) {
    fetchPlans();
  }

  Future<void> fetchPlans({String? repId, bool forceRefresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getTourPlans(
      repId: repId,
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (plans) {
        state = state.copyWith(isLoading: false, plans: plans);
      },
      onFailure: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> addPlan(TourPlan plan) async {
    final result = await _repository.addTourPlan(plan);
    result.when(
      onSuccess: (newPlan) {
        state = state.copyWith(plans: [newPlan, ...state.plans]);
      },
      onFailure: (_) {},
    );
  }

  Future<void> updatePlan(TourPlan plan) async {
    final result = await _repository.updateTourPlan(plan);
    result.when(
      onSuccess: (updated) {
        state = state.copyWith(
          plans: state.plans.map((e) => e.id == updated.id ? updated : e).toList(),
        );
      },
      onFailure: (_) {},
    );
  }
}

final tourPlanNotifierProvider = StateNotifierProvider<TourPlanNotifier, TourPlanState>((ref) {
  final repo = ref.watch(tourPlanRepositoryProvider);
  return TourPlanNotifier(repo);
});

// Manage current active stops list in scheduler
class TourPlanStopsState {
  final List<TourPlanStop> stops;
  final bool isLoading;
  final String? error;

  TourPlanStopsState({
    required this.stops,
    required this.isLoading,
    this.error,
  });

  factory TourPlanStopsState.initial() => TourPlanStopsState(stops: [], isLoading: false);

  TourPlanStopsState copyWith({
    List<TourPlanStop>? stops,
    bool? isLoading,
    String? error,
  }) {
    return TourPlanStopsState(
      stops: stops ?? this.stops,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TourPlanStopsNotifier extends StateNotifier<TourPlanStopsState> {
  final TourPlanRepository _repository;
  final String tourPlanId;

  TourPlanStopsNotifier(this._repository, this.tourPlanId) : super(TourPlanStopsState.initial()) {
    fetchStops();
  }

  Future<void> fetchStops() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getTourPlanStops(tourPlanId);
    result.when(
      onSuccess: (stops) {
        state = state.copyWith(isLoading: false, stops: stops);
      },
      onFailure: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> updateStopsOrder(List<TourPlanStop> reorderedStops) async {
    final updatedList = List<TourPlanStop>.generate(reorderedStops.length, (index) {
      return reorderedStops[index].copyWith(sequenceOrder: index + 1);
    });
    state = state.copyWith(stops: updatedList);
    await _repository.saveTourPlanStops(updatedList);
  }

  Future<void> addStop(TourPlanStop stop) async {
    final updatedStops = [...state.stops, stop];
    await updateStopsOrder(updatedStops);
  }

  Future<void> removeStop(String stopId) async {
    final updatedStops = state.stops.where((e) => e.id != stopId).toList();
    await updateStopsOrder(updatedStops);
  }

  Future<void> checkIn(TourPlanStop stop) async {
    final result = await _repository.checkInStop(stop);
    result.when(
      onSuccess: (updatedStop) {
        state = state.copyWith(
          stops: state.stops.map((e) => e.id == updatedStop.id ? updatedStop : e).toList(),
        );
      },
      onFailure: (_) {},
    );
  }
}

final tourPlanStopsProvider = StateNotifierProvider.family<TourPlanStopsNotifier, TourPlanStopsState, String>((ref, tourPlanId) {
  final repo = ref.watch(tourPlanRepositoryProvider);
  return TourPlanStopsNotifier(repo, tourPlanId);
});
