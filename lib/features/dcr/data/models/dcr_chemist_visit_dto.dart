import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_chemist_visit.dart';

class DcrChemistVisitDto {
  final String id;
  final String dcrId;
  final String chemistId;
  final String session;
  final DateTime? visitTime;
  final String? notes;
  final double? gpsLat;
  final double? gpsLng;
  final String? photoUrl;
  final bool isPlanned;
  final DateTime createdAt;

  DcrChemistVisitDto({
    required this.id,
    required this.dcrId,
    required this.chemistId,
    required this.session,
    this.visitTime,
    this.notes,
    this.gpsLat,
    this.gpsLng,
    this.photoUrl,
    required this.isPlanned,
    required this.createdAt,
  });

  factory DcrChemistVisitDto.fromJson(Map<String, dynamic> json) {
    return DcrChemistVisitDto(
      id: json['id'] as String,
      dcrId: json['dcr_id'] as String,
      chemistId: json['chemist_id'] as String,
      session: json['session'] as String,
      visitTime: json['visit_time'] != null ? DateTime.parse(json['visit_time'] as String) : null,
      notes: json['notes'] as String?,
      gpsLat: (json['gps_lat'] as num?)?.toDouble(),
      gpsLng: (json['gps_lng'] as num?)?.toDouble(),
      photoUrl: json['photo_url'] as String?,
      isPlanned: json['is_planned'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dcr_id': dcrId,
      'chemist_id': chemistId,
      'session': session,
      'visit_time': visitTime?.toIso8601String(),
      'notes': notes,
      'gps_lat': gpsLat,
      'gps_lng': gpsLng,
      'photo_url': photoUrl,
      'is_planned': isPlanned,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory DcrChemistVisitDto.fromDb(DcrChemistVisitsTableData dbData) {
    return DcrChemistVisitDto(
      id: dbData.id,
      dcrId: dbData.dcrId,
      chemistId: dbData.chemistId,
      session: dbData.session,
      visitTime: dbData.visitTime,
      notes: dbData.notes,
      gpsLat: dbData.gpsLat,
      gpsLng: dbData.gpsLng,
      photoUrl: dbData.photoUrl,
      isPlanned: dbData.isPlanned,
      createdAt: dbData.createdAt,
    );
  }

  DcrChemistVisitsTableCompanion toCompanion() {
    return DcrChemistVisitsTableCompanion(
      id: Value(id),
      dcrId: Value(dcrId),
      chemistId: Value(chemistId),
      session: Value(session),
      visitTime: Value(visitTime),
      notes: Value(notes),
      gpsLat: Value(gpsLat),
      gpsLng: Value(gpsLng),
      photoUrl: Value(photoUrl),
      isPlanned: Value(isPlanned),
      createdAt: Value(createdAt),
    );
  }

  DcrChemistVisit toDomain() {
    return DcrChemistVisit(
      id: id,
      dcrId: dcrId,
      chemistId: chemistId,
      session: session,
      visitTime: visitTime,
      notes: notes,
      gpsLat: gpsLat,
      gpsLng: gpsLng,
      photoUrl: photoUrl,
      isPlanned: isPlanned,
      createdAt: createdAt,
    );
  }

  factory DcrChemistVisitDto.fromDomain(DcrChemistVisit domain) {
    return DcrChemistVisitDto(
      id: domain.id,
      dcrId: domain.dcrId,
      chemistId: domain.chemistId,
      session: domain.session,
      visitTime: domain.visitTime,
      notes: domain.notes,
      gpsLat: domain.gpsLat,
      gpsLng: domain.gpsLng,
      photoUrl: domain.photoUrl,
      isPlanned: domain.isPlanned,
      createdAt: domain.createdAt,
    );
  }
}
