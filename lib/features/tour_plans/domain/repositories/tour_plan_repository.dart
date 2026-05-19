import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';

abstract class TourPlanRepository {
  Future<ApiResult<List<TourPlan>>> getTourPlans({
    int page = 1,
    int limit = 15,
    String? repId,
    bool forceRefresh = false,
  });

  Future<ApiResult<TourPlan>> addTourPlan(TourPlan tourPlan);
  Future<ApiResult<TourPlan>> updateTourPlan(TourPlan tourPlan);
  Future<ApiResult<void>> deleteTourPlan(String id);

  Future<ApiResult<List<TourPlanStop>>> getTourPlanStops(String tourPlanId);
  Future<ApiResult<void>> saveTourPlanStops(List<TourPlanStop> stops);
  Future<ApiResult<TourPlanStop>> checkInStop(TourPlanStop stop);
}
