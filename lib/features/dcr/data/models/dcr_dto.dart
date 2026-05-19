import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/dcr/domain/entities/dcr.dart';

class DcrDto {
  final String id;
  final String repId;
  final DateTime date;
  final String status;
  final String? managerComment;
  final String? voiceMemoUrl;
  final DateTime? submittedAt;
  final DateTime createdAt;

  DcrDto({
    required this.id,
    required this.repId,
    required this.date,
    required this.status,
    this.managerComment,
    this.voiceMemoUrl,
    this.submittedAt,
    required this.createdAt,
  });

  factory DcrDto.fromJson(Map<String, dynamic> json) {
    return DcrDto(
      id: json['id'] as String,
      repId: json['rep_id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      managerComment: json['manager_comment'] as String?,
      voiceMemoUrl: json['voice_memo_url'] as String?,
      submittedAt: json['submitted_at'] != null ? DateTime.parse(json['submitted_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rep_id': repId,
      'date': date.toIso8601String(),
      'status': status,
      'manager_comment': managerComment,
      'voice_memo_url': voiceMemoUrl,
      'submitted_at': submittedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory DcrDto.fromDb(DcrsTableData dbData) {
    return DcrDto(
      id: dbData.id,
      repId: dbData.repId,
      date: dbData.date,
      status: dbData.status,
      managerComment: dbData.managerComment,
      voiceMemoUrl: dbData.voiceMemoUrl,
      submittedAt: dbData.submittedAt,
      createdAt: dbData.createdAt,
    );
  }

  DcrsTableCompanion toCompanion() {
    return DcrsTableCompanion(
      id: Value(id),
      repId: Value(repId),
      date: Value(date),
      status: Value(status),
      managerComment: Value(managerComment),
      voiceMemoUrl: Value(voiceMemoUrl),
      submittedAt: Value(submittedAt),
      createdAt: Value(createdAt),
    );
  }

  Dcr toDomain() {
    return Dcr(
      id: id,
      repId: repId,
      date: date,
      status: status,
      managerComment: managerComment,
      voiceMemoUrl: voiceMemoUrl,
      submittedAt: submittedAt,
      createdAt: createdAt,
    );
  }

  factory DcrDto.fromDomain(Dcr domain) {
    return DcrDto(
      id: domain.id,
      repId: domain.repId,
      date: domain.date,
      status: domain.status,
      managerComment: domain.managerComment,
      voiceMemoUrl: domain.voiceMemoUrl,
      submittedAt: domain.submittedAt,
      createdAt: domain.createdAt,
    );
  }
}
