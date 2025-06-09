import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';

class PatienthistoryUiState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final Patient? patient;
  final int totalDiagnosis;
  final List<DiagnosisHistory> diagnosisList;

  PatienthistoryUiState({
    required this.patient,
    this.diagnosisList = const [],
    this.totalDiagnosis = 0,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  PatienthistoryUiState copywith({
    Patient? patient,
    List<DiagnosisHistory>? diagnosisList,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    int? totalDiagnosis
  }) {
    return PatienthistoryUiState(
      patient: patient ?? this.patient,
      diagnosisList: diagnosisList ?? this.diagnosisList,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      totalDiagnosis: totalDiagnosis?? this.totalDiagnosis,
      error: error,
    );
  }
}