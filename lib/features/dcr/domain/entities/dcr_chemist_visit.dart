import 'package:equatable/equatable.dart';

class DcrChemistVisit extends Equatable {
  final String id;
  final String dcrId;
  final String chemistId;
  final String session; // 'morning', 'evening'
  final DateTime? visitTime;
  final String? notes;
  final double? gpsLat;
  final double? gpsLng;
  final String? photoUrl;
  final bool isPlanned;
  final DateTime createdAt;

  const DcrChemistVisit({
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

  DcrChemistVisit copyWith({
    String? id,
    String? dcrId,
    String? chemistId,
    String? session,
    DateTime? visitTime,
    String? notes,
    double? gpsLat,
    double? gpsLng,
    String? photoUrl,
    bool? isPlanned,
    DateTime? createdAt,
  }) {
    return DcrChemistVisit(
      id: id ?? this.id,
      dcrId: dcrId ?? this.dcrId,
      chemistId: chemistId ?? this.chemistId,
      session: session ?? this.session,
      visitTime: visitTime ?? this.visitTime,
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
        chemistId,
        session,
        visitTime,
        notes,
        gpsLat,
        gpsLng,
        photoUrl,
        isPlanned,
        createdAt,
      ];
}
