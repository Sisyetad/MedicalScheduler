import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';

class DataQueue {
  int status;
  Patient patient;
  Doctor? doctor;
  final int queueId;
  final String createdAt;
  String? updatedAt;

  DataQueue({
    required this.status,
    required this.patient,
    this.doctor,
    required this.queueId,
    required this.createdAt,
    this.updatedAt,
  });

  DataQueue copyWith({
    int? status,
    Patient? patient,
    Doctor? doctor,
    String? updatedAt,
  }) {
    return DataQueue(
      status: status ?? this.status,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      updatedAt: updatedAt ?? this.updatedAt,
      queueId: queueId,
      createdAt: createdAt,
    );
  }
}
