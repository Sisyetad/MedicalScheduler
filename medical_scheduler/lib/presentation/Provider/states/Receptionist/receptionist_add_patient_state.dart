import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';

class ReceptionistAddPatientState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final PatientRequestModel? patient;

  ReceptionistAddPatientState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.patient,
  });

  ReceptionistAddPatientState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    PatientRequestModel? patient,
  }) {
    return ReceptionistAddPatientState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      patient: patient ?? this.patient,
    );
  }
}
