import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_doctor_visit.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_chemist_visit.dart';

abstract class DcrRepository {
  Future<ApiResult<List<Dcr>>> getDcrsByRep(String repId, {bool forceRefresh = false});
  Future<ApiResult<Dcr?>> getTodayDcr(String repId, DateTime date);
  Future<ApiResult<void>> createOrUpdateDcr(Dcr dcr);

  // Visits
  Future<ApiResult<List<DcrDoctorVisit>>> getDoctorVisits(String dcrId);
  Future<ApiResult<void>> addDoctorVisit(DcrDoctorVisit visit);
  Future<ApiResult<void>> deleteDoctorVisit(String visitId);

  Future<ApiResult<List<DcrChemistVisit>>> getChemistVisits(String dcrId);
  Future<ApiResult<void>> addChemistVisit(DcrChemistVisit visit);
  Future<ApiResult<void>> deleteChemistVisit(String visitId);

  // Sync
  Future<ApiResult<void>> syncPendingDcrs();
}
