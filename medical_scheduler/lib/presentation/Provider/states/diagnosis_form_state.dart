import 'package:medical_scheduler/data/model/diagnosis_request_model.dart';

class DiagnosisFormState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final DiagnosisRequestModel diagnosis;

  DiagnosisFormState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    DiagnosisRequestModel? diagnosis
  }): diagnosis = diagnosis?? DiagnosisRequestModel.empty();

  DiagnosisFormState copywith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    DiagnosisRequestModel? diagnosis,
  }) {
    return DiagnosisFormState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      diagnosis: diagnosis ?? this.diagnosis,
    );
  }
}
