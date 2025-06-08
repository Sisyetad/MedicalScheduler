import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/data/model/diagnosis_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/Application/Usecases/doctor/createDiagnosis.dart';
import 'package:medical_scheduler/presentation/Provider/states/diagnosis_form_state.dart';
import 'package:medical_scheduler/presentation/events/diagnosis_form_events.dart';

class DiagnosisFormNotifier extends StateNotifier<DiagnosisFormState> {
  final CreateDiagnosis createDiagnosisUseCase;

  DiagnosisFormNotifier(this.createDiagnosisUseCase)
    : super(DiagnosisFormState());

  Future<void> mapEventToState(DiagnosisFormEvents event) async {
    if (event is UpdateDiagnosis) {
      _updateDiagnosis(event.diagnosisHistory);
    } else if (event is SubmitForm) {
      await _submitForm();
    }
  }

  void _updateDiagnosis(DiagnosisHistory diagnosis) {
    final newRequest = DiagnosisRequestModel(
      diagnosisName: diagnosis.diagnosisName,
      comment: diagnosis.comment,
      medication: diagnosis.medication,
      doctorId: diagnosis.doctor.userId,
      patientId: diagnosis.patient.userId,
      visible: true,
    );

    state = state.copywith(diagnosis: newRequest);
  }

  Future<void> _submitForm() async {
    try {
      state = state.copywith(isLoading: true, error: null);
      await createDiagnosisUseCase(
        CreateDiagnosisParams(diagnosisRequest: state.diagnosis),
      );
      state = state.copywith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copywith(isLoading: false, error: e.toString());
    }
  }
}
