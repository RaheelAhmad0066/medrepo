import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/features/doctors/data/models/doctor_dto.dart';

class DoctorRemoteDataSource {
  final DioClient _dioClient;

  DoctorRemoteDataSource(this._dioClient);

  Future<List<DoctorDto>> getDoctors({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? tier,
    String? lastModifiedAfter,
  }) async {
    final Map<String, dynamic> params = {
      'page': page,
      'limit': limit,
    };
    if (searchQuery != null && searchQuery.isNotEmpty) {
      params['search'] = searchQuery;
    }
    if (tier != null && tier.isNotEmpty) {
      params['tier'] = tier;
    }
    if (lastModifiedAfter != null) {
      params['modified_after'] = lastModifiedAfter;
    }

    final response = await _dioClient.get('/doctors', queryParameters: params);
    final data = response.data;
    if (data is List) {
      return data.map((json) => DoctorDto.fromJson(json as Map<String, dynamic>)).toList();
    } else if (data is Map && data['data'] is List) {
      return (data['data'] as List).map((json) => DoctorDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<DoctorDto> addDoctor(DoctorDto doctor) async {
    final response = await _dioClient.post('/doctors', data: doctor.toJson());
    return DoctorDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<DoctorDto> updateDoctor(DoctorDto doctor) async {
    final response = await _dioClient.put('/doctors', data: doctor.toJson());
    return DoctorDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteDoctor(String doctorId) async {
    await _dioClient.delete('/doctors', data: {'id': doctorId});
  }
}
