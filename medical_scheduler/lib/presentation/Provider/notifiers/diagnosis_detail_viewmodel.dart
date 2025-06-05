import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/domain/usecases/doctor/getDiagnosis.dart';
import 'package:medical_scheduler/presentation/Provider/states/diagnosis_detail_state.dart';


class DiagnosisDetailNotifier extends StateNotifier<DiagnosisDetailUiState> {
  final GetDiagnosisById getDiagnosisById;

  DiagnosisDetailNotifier({required this.getDiagnosisById})
      : super(DiagnosisDetailUiState());

  Future<void> fetchDiagnosis(int id) async {
    try {
      state = state.copyWith(isLoading: true, error: null, isSuccess: false);
      final diagnosis = await getDiagnosisById(id);
      state = state.copyWith(
        diagnosis: diagnosis,
        isLoading: false,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      );
    }
  }
}
