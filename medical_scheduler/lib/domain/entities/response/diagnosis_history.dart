import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';

class DiagnosisHistory {
  final int diagnosisId;
  final String diagnosisName;
  final String createdTime;
  String? updatedAt;
  final Doctor doctor;
  final String medication;
  final String comment;
  final Patient patient;
  final bool visible;

  DiagnosisHistory({
    required this.diagnosisId,
    required this.diagnosisName,
    required this.doctor,
    required this.medication,
    required this.createdTime,
    required this.comment,
    required this.patient,
    this.updatedAt,
    this.visible = false,
  });

  DiagnosisHistory copyWith({
    String? medication,
    String? comment,
    String? updatedAt,
    bool? visible,
  }) {
    return DiagnosisHistory(
      diagnosisId: diagnosisId,
      diagnosisName: diagnosisName,
      doctor: doctor,
      medication: this.medication + (medication != null ? ' $medication' : ''),
      comment: this.comment + (comment != null ? ' $comment' : ''),
      patient: patient,
      createdTime: createdTime,
      updatedAt: updatedAt ?? DateTime.now().toIso8601String(),
      visible: visible ?? this.visible,
    );
  }
}
