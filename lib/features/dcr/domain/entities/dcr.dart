import 'package:equatable/equatable.dart';

class Dcr extends Equatable {
  final String id;
  final String repId;
  final DateTime date;
  final String status; // 'draft', 'submitted', 'acknowledged'
  final String? managerComment;
  final String? voiceMemoUrl;
  final DateTime? submittedAt;
  final DateTime createdAt;

  const Dcr({
    required this.id,
    required this.repId,
    required this.date,
    required this.status,
    this.managerComment,
    this.voiceMemoUrl,
    this.submittedAt,
    required this.createdAt,
  });

  Dcr copyWith({
    String? id,
    String? repId,
    DateTime? date,
    String? status,
    String? managerComment,
    String? voiceMemoUrl,
    DateTime? submittedAt,
    DateTime? createdAt,
  }) {
    return Dcr(
      id: id ?? this.id,
      repId: repId ?? this.repId,
      date: date ?? this.date,
      status: status ?? this.status,
      managerComment: managerComment ?? this.managerComment,
      voiceMemoUrl: voiceMemoUrl ?? this.voiceMemoUrl,
      submittedAt: submittedAt ?? this.submittedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        repId,
        date,
        status,
        managerComment,
        voiceMemoUrl,
        submittedAt,
        createdAt,
      ];
}
