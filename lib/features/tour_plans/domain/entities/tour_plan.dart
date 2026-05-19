import 'package:equatable/equatable.dart';

class TourPlan extends Equatable {
  final String id;
  final String tenantId;
  final String repId;
  final DateTime plannedDate;
  final List<String> routeOptimizationOrder; // List of stop IDs in optimized sequence order
  final String status; // 'Draft', 'Pending Approval', 'Approved', 'Rejected'
  final String? managerComment;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;

  const TourPlan({
    required this.id,
    required this.tenantId,
    required this.repId,
    required this.plannedDate,
    required this.routeOptimizationOrder,
    this.status = 'Draft',
    this.managerComment,
    required this.clientCreatedAt,
    required this.lastModifiedAt,
    this.isDeleted = false,
  });

  TourPlan copyWith({
    String? id,
    String? tenantId,
    String? repId,
    DateTime? plannedDate,
    List<String>? routeOptimizationOrder,
    String? status,
    String? managerComment,
    DateTime? clientCreatedAt,
    DateTime? lastModifiedAt,
    bool? isDeleted,
  }) {
    return TourPlan(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      repId: repId ?? this.repId,
      plannedDate: plannedDate ?? this.plannedDate,
      routeOptimizationOrder: routeOptimizationOrder ?? this.routeOptimizationOrder,
      status: status ?? this.status,
      managerComment: managerComment ?? this.managerComment,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tenantId,
        repId,
        plannedDate,
        routeOptimizationOrder,
        status,
        managerComment,
        clientCreatedAt,
        lastModifiedAt,
        isDeleted,
      ];
}

class TourPlanStop extends Equatable {
  final String id;
  final String tourPlanId;
  final String targetType; // 'Doctor' or 'Chemist'
  final String targetId;
  final int sequenceOrder;
  final bool checkedIn;
  final DateTime? checkInTime;
  final double? checkInLatitude;
  final double? checkInLongitude;
  final String? deviationReason;

  const TourPlanStop({
    required this.id,
    required this.tourPlanId,
    required this.targetType,
    required this.targetId,
    required this.sequenceOrder,
    this.checkedIn = false,
    this.checkInTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.deviationReason,
  });

  TourPlanStop copyWith({
    String? id,
    String? tourPlanId,
    String? targetType,
    String? targetId,
    int? sequenceOrder,
    bool? checkedIn,
    DateTime? checkInTime,
    double? checkInLatitude,
    double? checkInLongitude,
    String? deviationReason,
  }) {
    return TourPlanStop(
      id: id ?? this.id,
      tourPlanId: tourPlanId ?? this.tourPlanId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      sequenceOrder: sequenceOrder ?? this.sequenceOrder,
      checkedIn: checkedIn ?? this.checkedIn,
      checkInTime: checkInTime ?? this.checkInTime,
      checkInLatitude: checkInLatitude ?? this.checkInLatitude,
      checkInLongitude: checkInLongitude ?? this.checkInLongitude,
      deviationReason: deviationReason ?? this.deviationReason,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tourPlanId,
        targetType,
        targetId,
        sequenceOrder,
        checkedIn,
        checkInTime,
        checkInLatitude,
        checkInLongitude,
        deviationReason,
      ];
}
