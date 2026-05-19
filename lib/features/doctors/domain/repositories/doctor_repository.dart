import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';

abstract class DoctorRepository {
  Future<ApiResult<List<Doctor>>> getDoctors({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? tier,
    bool forceRefresh = false,
  });

  Future<ApiResult<Doctor>> addDoctor(Doctor doctor);

  Future<ApiResult<Doctor>> updateDoctor(Doctor doctor);

  Future<ApiResult<void>> deleteDoctor(String doctorId);
  
  Future<ApiResult<void>> importDoctorsFromExcel(List<Doctor> doctors);
}
