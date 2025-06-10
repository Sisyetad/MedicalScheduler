import 'package:medical_scheduler/domain/entities/response/patient.dart';

class ReceptionistAddPatientState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final Patient? patient;

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
    Patient? patient,
  }) {
    return ReceptionistAddPatientState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      patient: patient ?? this.patient,
    );
  }
}
