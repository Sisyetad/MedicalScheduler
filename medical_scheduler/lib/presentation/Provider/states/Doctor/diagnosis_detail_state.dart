import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';

class DiagnosisDetailUiState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final DiagnosisHistory? diagnosis;

  DiagnosisDetailUiState({
    this.isLoading = false,
    this.isSuccess = false,
    this.diagnosis,
    this.error,
  });

  DiagnosisDetailUiState copyWith({
    DiagnosisHistory? diagnosis,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return DiagnosisDetailUiState(
      diagnosis: diagnosis ?? this.diagnosis,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}
