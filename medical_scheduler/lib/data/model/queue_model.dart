import 'package:medical_scheduler/data/model/doctor_model.dart';
import 'package:medical_scheduler/data/model/patient_model.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';

class DataQueueModel extends DataQueue {
  DataQueueModel({
    required super.queueId,
    required super.status,
    required super.createdAt,
    required super.patient,
    super.doctor,
    super.updatedAt,
  });

  factory DataQueueModel.fromJson(Map<String, dynamic> json) {
    return DataQueueModel(
      queueId: json['queue_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      patient: PatientModel.fromJson(json['patient']),
      doctor: json['doctor'] != null
          ? DoctorModel.fromJson(json['doctor'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'queue_id': queueId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'patient': (patient as PatientModel).toJson(),
      'doctor': doctor != null ? (doctor as DoctorModel).toJson() : null,
    };
  }
}
