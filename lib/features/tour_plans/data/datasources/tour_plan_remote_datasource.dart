import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/data/models/tour_plan_dto.dart';

class TourPlanRemoteDataSource {
  final DioClient _dioClient;

  TourPlanRemoteDataSource(this._dioClient);

  Future<List<TourPlan>> getTourPlans({
    int page = 1,
    int limit = 15,
    String? repId,
    String? lastModifiedAfter,
  }) async {
    final Map<String, dynamic> params = {
      'page': page,
      'limit': limit,
    };
    if (repId != null && repId.isNotEmpty) {
      params['rep_id'] = repId;
    }
    if (lastModifiedAfter != null) {
      params['modified_after'] = lastModifiedAfter;
    }

    final response = await _dioClient.get('/tour-plans', queryParameters: params);
    final data = response.data;
    if (data is List) {
      return data.map((json) => TourPlanDto.fromJson(json as Map<String, dynamic>)).toList();
    } else if (data is Map && data['data'] is List) {
      return (data['data'] as List).map((json) => TourPlanDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<TourPlan> addTourPlan(TourPlan tourPlan) async {
    final response = await _dioClient.post('/tour-plans', data: TourPlanDto.toJson(tourPlan));
    return TourPlanDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<TourPlan> updateTourPlan(TourPlan tourPlan) async {
    final response = await _dioClient.put('/tour-plans', data: TourPlanDto.toJson(tourPlan));
    return TourPlanDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteTourPlan(String id) async {
    await _dioClient.delete('/tour-plans', data: {'id': id});
  }

  Future<List<TourPlanStop>> getTourPlanStops(String tourPlanId) async {
    final response = await _dioClient.get('/tour-plans/stops', queryParameters: {'tour_plan_id': tourPlanId});
    final data = response.data;
    if (data is List) {
      return data.map((json) => TourPlanStopDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<void> saveTourPlanStops(List<TourPlanStop> stops) async {
    await _dioClient.post('/tour-plans/stops', data: stops.map((e) => TourPlanStopDto.toJson(e)).toList());
  }

  Future<TourPlanStop> checkInStop(TourPlanStop stop) async {
    final response = await _dioClient.post('/tour-plans/check-in', data: TourPlanStopDto.toJson(stop));
    return TourPlanStopDto.fromJson(response.data as Map<String, dynamic>);
  }
}
