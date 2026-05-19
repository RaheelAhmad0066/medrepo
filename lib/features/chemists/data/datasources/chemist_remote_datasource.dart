import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/features/chemists/data/models/chemist_dto.dart';

class ChemistRemoteDataSource {
  final DioClient _dioClient;

  ChemistRemoteDataSource(this._dioClient);

  Future<List<ChemistDto>> getChemists({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? priorityTag,
    String? lastModifiedAfter,
  }) async {
    final Map<String, dynamic> params = {
      'page': page,
      'limit': limit,
    };
    if (searchQuery != null && searchQuery.isNotEmpty) {
      params['search'] = searchQuery;
    }
    if (priorityTag != null && priorityTag.isNotEmpty) {
      params['priority_tag'] = priorityTag;
    }
    if (lastModifiedAfter != null) {
      params['modified_after'] = lastModifiedAfter;
    }

    final response = await _dioClient.get('/chemists', queryParameters: params);
    final data = response.data;
    if (data is List) {
      return data.map((json) => ChemistDto.fromJson(json as Map<String, dynamic>)).toList();
    } else if (data is Map && data['data'] is List) {
      return (data['data'] as List).map((json) => ChemistDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<ChemistDto> addChemist(ChemistDto chemist) async {
    final response = await _dioClient.post('/chemists', data: chemist.toJson());
    return ChemistDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ChemistDto> updateChemist(ChemistDto chemist) async {
    final response = await _dioClient.put('/chemists', data: chemist.toJson());
    return ChemistDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteChemist(String chemistId) async {
    await _dioClient.delete('/chemists', data: {'id': chemistId});
  }
}
