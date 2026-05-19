import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state.dart';
import 'package:medrep_pro/features/auth/presentation/providers/auth_state_notifier.dart';
import 'package:medrep_pro/features/dcr/data/datasources/dcr_local_datasource.dart';
import 'package:medrep_pro/features/dcr/data/datasources/dcr_remote_datasource.dart';
import 'package:medrep_pro/features/dcr/data/repositories/dcr_repository_impl.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_doctor_visit.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_chemist_visit.dart';
import 'package:medrep_pro/features/dcr/domain/repositories/dcr_repository.dart';

final dcrLocalDataSourceProvider = Provider<DcrLocalDataSource>((ref) {
  return DcrLocalDataSource(ref.watch(appDatabaseProvider));
});

final dcrRemoteDataSourceProvider = Provider<DcrRemoteDataSource>((ref) {
  return DcrRemoteDataSource(ref.watch(supabaseClientProvider));
});

final dcrRepositoryProvider = Provider<DcrRepository>((ref) {
  return DcrRepositoryImpl(
    remoteDataSource: ref.watch(dcrRemoteDataSourceProvider),
    localDataSource: ref.watch(dcrLocalDataSourceProvider),
    connectivityService: ref.watch(connectivityProvider),
  );
});

final todayDcrProvider = FutureProvider<Dcr?>((ref) async {
  final authState = ref.watch(authStateProvider);
  if (authState is! AuthAuthenticated) return null;
  final repId = authState.user.id;
  final today = DateTime.now();

  final repo = ref.watch(dcrRepositoryProvider);
  final result = await repo.getTodayDcr(repId, today);

  if (result is Success<Dcr?>) {
    if (result.data != null) return result.data;
    
    // Auto-create draft DCR if one doesn't exist
    final newDcr = Dcr(
      id: const Uuid().v4(),
      repId: repId,
      date: today,
      status: 'draft',
      createdAt: DateTime.now(),
    );
    await repo.createOrUpdateDcr(newDcr);
    return newDcr;
  }
  return null;
});

final dcrListProvider = FutureProvider<List<Dcr>>((ref) async {
  final authState = ref.watch(authStateProvider);
  if (authState is! AuthAuthenticated) return [];
  final repId = authState.user.id;

  final repo = ref.watch(dcrRepositoryProvider);
  final result = await repo.getDcrsByRep(repId);
  return result is Success<List<Dcr>> ? result.data : [];
});

final dcrDoctorVisitsProvider = FutureProvider.family<List<DcrDoctorVisit>, String>((ref, dcrId) async {
  final repo = ref.watch(dcrRepositoryProvider);
  final result = await repo.getDoctorVisits(dcrId);
  return result is Success<List<DcrDoctorVisit>> ? result.data : [];
});

final dcrChemistVisitsProvider = FutureProvider.family<List<DcrChemistVisit>, String>((ref, dcrId) async {
  final repo = ref.watch(dcrRepositoryProvider);
  final result = await repo.getChemistVisits(dcrId);
  return result is Success<List<DcrChemistVisit>> ? result.data : [];
});

class DcrSubmitNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<bool> submitDcr(Dcr dcr) async {
    state = true;
    final repo = ref.read(dcrRepositoryProvider);
    final updatedDcr = dcr.copyWith(status: 'submitted', submittedAt: DateTime.now());
    final result = await repo.createOrUpdateDcr(updatedDcr);
    state = false;
    if (result is Success) {
      ref.invalidate(todayDcrProvider);
      ref.invalidate(dcrListProvider);
      return true;
    }
    return false;
  }
}

final dcrSubmitProvider = NotifierProvider<DcrSubmitNotifier, bool>(() {
  return DcrSubmitNotifier();
});
