import 'package:medical_scheduler/domain/entities/request/diagnosis_request.dart';

class DiagnosisRequestModel extends DiagnosisRequest {
  DiagnosisRequestModel({
    required super.diagnosisName,
    required super.medication,
    required super.comment,
    required super.doctorId,
    required super.patientId,
    required super.visible,
  });

  Map<String, dynamic> toJson() {
    return {
      'diagnosis_name': diagnosisName,
      'prescription': medication,
      'diagnosis_details': comment,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'visible': true,
    };
  }

    factory DiagnosisRequestModel.empty() {
    return DiagnosisRequestModel(
      comment: '',
      diagnosisName: '',
      doctorId: 0,
      medication: '',
      patientId: 0,
      visible: true,
    );
  }

    DiagnosisRequestModel copyWith({
    String? diagnosisName,
    int? patientId,
    int? doctorId,
    bool? visible,
    String? medication,
    String? comment,
  }) {
    return DiagnosisRequestModel(
      diagnosisName: diagnosisName ?? this.diagnosisName,
      medication: medication ?? this.medication,
      comment: comment ?? this.comment,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      visible: visible ?? this.visible,
    );
  }
}
