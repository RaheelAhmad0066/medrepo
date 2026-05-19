import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr_doctor_visit.dart';

class DcrDoctorVisitDto {
  final String id;
  final String dcrId;
  final String doctorId;
  final String session;
  final DateTime? visitTime;
  final String? callOutcome;
  final String? notes;
  final double? gpsLat;
  final double? gpsLng;
  final String? photoUrl;
  final bool isPlanned;
  final DateTime createdAt;

  DcrDoctorVisitDto({
    required this.id,
    required this.dcrId,
    required this.doctorId,
    required this.session,
    this.visitTime,
    this.callOutcome,
    this.notes,
    this.gpsLat,
    this.gpsLng,
    this.photoUrl,
    required this.isPlanned,
    required this.createdAt,
  });

  factory DcrDoctorVisitDto.fromJson(Map<String, dynamic> json) {
    return DcrDoctorVisitDto(
      id: json['id'] as String,
      dcrId: json['dcr_id'] as String,
      doctorId: json['doctor_id'] as String,
      session: json['session'] as String,
      visitTime: json['visit_time'] != null ? DateTime.parse(json['visit_time'] as String) : null,
      callOutcome: json['call_outcome'] as String?,
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
      'doctor_id': doctorId,
      'session': session,
      'visit_time': visitTime?.toIso8601String(),
      'call_outcome': callOutcome,
      'notes': notes,
      'gps_lat': gpsLat,
      'gps_lng': gpsLng,
      'photo_url': photoUrl,
      'is_planned': isPlanned,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory DcrDoctorVisitDto.fromDb(DcrDoctorVisitsTableData dbData) {
    return DcrDoctorVisitDto(
      id: dbData.id,
      dcrId: dbData.dcrId,
      doctorId: dbData.doctorId,
      session: dbData.session,
      visitTime: dbData.visitTime,
      callOutcome: dbData.callOutcome,
      notes: dbData.notes,
      gpsLat: dbData.gpsLat,
      gpsLng: dbData.gpsLng,
      photoUrl: dbData.photoUrl,
      isPlanned: dbData.isPlanned,
      createdAt: dbData.createdAt,
    );
  }

  DcrDoctorVisitsTableCompanion toCompanion() {
    return DcrDoctorVisitsTableCompanion(
      id: Value(id),
      dcrId: Value(dcrId),
      doctorId: Value(doctorId),
      session: Value(session),
      visitTime: Value(visitTime),
      callOutcome: Value(callOutcome),
      notes: Value(notes),
      gpsLat: Value(gpsLat),
      gpsLng: Value(gpsLng),
      photoUrl: Value(photoUrl),
      isPlanned: Value(isPlanned),
      createdAt: Value(createdAt),
    );
  }

  DcrDoctorVisit toDomain() {
    return DcrDoctorVisit(
      id: id,
      dcrId: dcrId,
      doctorId: doctorId,
      session: session,
      visitTime: visitTime,
      callOutcome: callOutcome,
      notes: notes,
      gpsLat: gpsLat,
      gpsLng: gpsLng,
      photoUrl: photoUrl,
      isPlanned: isPlanned,
      createdAt: createdAt,
    );
  }

  factory DcrDoctorVisitDto.fromDomain(DcrDoctorVisit domain) {
    return DcrDoctorVisitDto(
      id: domain.id,
      dcrId: domain.dcrId,
      doctorId: domain.doctorId,
      session: domain.session,
      visitTime: domain.visitTime,
      callOutcome: domain.callOutcome,
      notes: domain.notes,
      gpsLat: domain.gpsLat,
      gpsLng: domain.gpsLng,
      photoUrl: domain.photoUrl,
      isPlanned: domain.isPlanned,
      createdAt: domain.createdAt,
    );
  }
}
