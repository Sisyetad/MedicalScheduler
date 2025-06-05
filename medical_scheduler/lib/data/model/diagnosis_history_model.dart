import 'package:medical_scheduler/data/model/doctor_model.dart';
import 'package:medical_scheduler/data/model/patient_model.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';

class DiagnosisHistoryModel extends DiagnosisHistory {
  DiagnosisHistoryModel({
    required super.diagnosisId,
    required super.diagnosisName,
    required super.doctor,
    required super.medication,
    required super.createdTime,
    required super.comment,
    required super.patient,
    required super.updatedAt 
  });

  factory DiagnosisHistoryModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisHistoryModel(
      diagnosisId: json['diagnosis_id'],
      diagnosisName: json['diagnosis_name'],
      doctor: DoctorModel.fromJson(json['doctor']) as Doctor,
      medication: json['prescription'],
      createdTime: json['created_at'],
      updatedAt: json['updated_at'],
      comment: json['diagnosis_details'],
      patient: PatientModel.fromJson(json['patient']), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diagnosisName': diagnosisName,
      'diagnosis_id' : diagnosisId,
      'doctor': doctor,
      'medication': medication,
      'createdTime': createdTime,
      'comment': comment,
      'patient': patient,
    };
  }
}

