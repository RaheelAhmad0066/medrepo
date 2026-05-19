import 'package:equatable/equatable.dart';

class DcrDoctorVisit extends Equatable {
  final String id;
  final String dcrId;
  final String doctorId;
  final String session; // 'morning', 'evening'
  final DateTime? visitTime;
  final String? callOutcome; // 'positive', 'neutral', 'needs_followup', 'not_found', 'rescheduled'
  final String? notes;
  final double? gpsLat;
  final double? gpsLng;
  final String? photoUrl;
  final bool isPlanned;
  final DateTime createdAt;

  const DcrDoctorVisit({
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

  DcrDoctorVisit copyWith({
    String? id,
    String? dcrId,
    String? doctorId,
    String? session,
    DateTime? visitTime,
    String? callOutcome,
    String? notes,
    double? gpsLat,
    double? gpsLng,
    String? photoUrl,
    bool? isPlanned,
    DateTime? createdAt,
  }) {
    return DcrDoctorVisit(
      id: id ?? this.id,
      dcrId: dcrId ?? this.dcrId,
      doctorId: doctorId ?? this.doctorId,
      session: session ?? this.session,
      visitTime: visitTime ?? this.visitTime,
      callOutcome: callOutcome ?? this.callOutcome,
      notes: notes ?? this.notes,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLng: gpsLng ?? this.gpsLng,
      photoUrl: photoUrl ?? this.photoUrl,
      isPlanned: isPlanned ?? this.isPlanned,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        dcrId,
        doctorId,
        session,
        visitTime,
        callOutcome,
        notes,
        gpsLat,
        gpsLng,
        photoUrl,
        isPlanned,
        createdAt,
      ];
}
