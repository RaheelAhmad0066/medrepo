import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';

class TourPlanDto {
  static TourPlan fromJson(Map<String, dynamic> json) {
    final rawOrder = json['route_optimization_order'];
    List<String> orderList = [];
    if (rawOrder is String) {
      orderList = List<String>.from(jsonDecode(rawOrder) as List);
    } else if (rawOrder is List) {
      orderList = List<String>.from(rawOrder);
    }
    return TourPlan(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String,
      repId: json['rep_id'] as String,
      plannedDate: DateTime.parse(json['planned_date'] as String),
      routeOptimizationOrder: orderList,
      status: json['status'] as String? ?? 'Draft',
      managerComment: json['manager_comment'] as String?,
      clientCreatedAt: DateTime.parse(json['client_created_at'] as String),
      lastModifiedAt: DateTime.parse(json['last_modified_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toJson(TourPlan plan) {
    return {
      'id': plan.id,
      'tenant_id': plan.tenantId,
      'rep_id': plan.repId,
      'planned_date': plan.plannedDate.toIso8601String(),
      'route_optimization_order': jsonEncode(plan.routeOptimizationOrder),
      'status': plan.status,
      'manager_comment': plan.managerComment,
      'client_created_at': plan.clientCreatedAt.toIso8601String(),
      'last_modified_at': plan.lastModifiedAt.toIso8601String(),
      'is_deleted': plan.isDeleted,
    };
  }

  static TourPlan fromDb(TourPlansTableData dbData) {
    List<String> orderList = [];
    try {
      orderList = List<String>.from(jsonDecode(dbData.routeOptimizationOrder) as List);
    } catch (_) {}
    return TourPlan(
      id: dbData.id,
      tenantId: dbData.tenantId,
      repId: dbData.repId,
      plannedDate: dbData.plannedDate,
      routeOptimizationOrder: orderList,
      status: dbData.status,
      managerComment: dbData.managerComment,
      clientCreatedAt: dbData.clientCreatedAt,
      lastModifiedAt: dbData.lastModifiedAt,
      isDeleted: dbData.isDeleted,
    );
  }

  static TourPlansTableCompanion toDbCompanion(TourPlan plan) {
    return TourPlansTableCompanion(
      id: Value(plan.id),
      tenantId: Value(plan.tenantId),
      repId: Value(plan.repId),
      plannedDate: Value(plan.plannedDate),
      routeOptimizationOrder: Value(jsonEncode(plan.routeOptimizationOrder)),
      status: Value(plan.status),
      managerComment: Value(plan.managerComment),
      clientCreatedAt: Value(plan.clientCreatedAt),
      lastModifiedAt: Value(plan.lastModifiedAt),
      isDeleted: Value(plan.isDeleted),
    );
  }
}

class TourPlanStopDto {
  static TourPlanStop fromJson(Map<String, dynamic> json) {
    return TourPlanStop(
      id: json['id'] as String,
      tourPlanId: json['tour_plan_id'] as String,
      targetType: json['target_type'] as String,
      targetId: json['target_id'] as String,
      sequenceOrder: json['sequence_order'] as int,
      checkedIn: json['checked_in'] as bool? ?? false,
      checkInTime: json['check_in_time'] != null ? DateTime.parse(json['check_in_time'] as String) : null,
      checkInLatitude: (json['check_in_latitude'] as num?)?.toDouble(),
      checkInLongitude: (json['check_in_longitude'] as num?)?.toDouble(),
      deviationReason: json['deviation_reason'] as String?,
    );
  }

  static Map<String, dynamic> toJson(TourPlanStop stop) {
    return {
      'id': stop.id,
      'tour_plan_id': stop.tourPlanId,
      'target_type': stop.targetType,
      'target_id': stop.targetId,
      'sequence_order': stop.sequenceOrder,
      'checked_in': stop.checkedIn,
      'check_in_time': stop.checkInTime?.toIso8601String(),
      'check_in_latitude': stop.checkInLatitude,
      'check_in_longitude': stop.checkInLongitude,
      'deviation_reason': stop.deviationReason,
    };
  }

  static TourPlanStop fromDb(TourPlanStopsTableData dbData) {
    return TourPlanStop(
      id: dbData.id,
      tourPlanId: dbData.tourPlanId,
      targetType: dbData.targetType,
      targetId: dbData.targetId,
      sequenceOrder: dbData.sequenceOrder,
      checkedIn: dbData.checkedIn,
      checkInTime: dbData.checkInTime,
      checkInLatitude: dbData.checkInLatitude,
      checkInLongitude: dbData.checkInLongitude,
      deviationReason: dbData.deviationReason,
    );
  }

  static TourPlanStopsTableCompanion toDbCompanion(TourPlanStop stop) {
    return TourPlanStopsTableCompanion(
      id: Value(stop.id),
      tourPlanId: Value(stop.tourPlanId),
      targetType: Value(stop.targetType),
      targetId: Value(stop.targetId),
      sequenceOrder: Value(stop.sequenceOrder),
      checkedIn: Value(stop.checkedIn),
      checkInTime: Value(stop.checkInTime),
      checkInLatitude: Value(stop.checkInLatitude),
      checkInLongitude: Value(stop.checkInLongitude),
      deviationReason: Value(stop.deviationReason),
    );
  }
}
