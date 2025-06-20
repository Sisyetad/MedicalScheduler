import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/diagnosis/displayDiagnoses.dart';
import 'package:medical_scheduler/Application/Usecases/patient/getpatient.dart';
import 'package:medical_scheduler/presentation/Provider/states/Doctor/patient_history_state.dart';
import 'package:medical_scheduler/presentation/events/Doctor/patient_history_events.dart';

class PatientHistoryNotifier extends StateNotifier<PatienthistoryUiState> {
  final GetAllDiagnoses getAllDiagnoses;
  final GetpatientById getPatientById;

  PatientHistoryNotifier({
    required this.getAllDiagnoses,
    required this.getPatientById,
  }) : super(PatienthistoryUiState(patient: null));

  Future<void> handleEvent(PatientHistoryEvent event) async {
    if (event is FetchPatientHistory) {
      await _fetchPatientHistory(event.patientId);
    } else if (event is NavigateToDiagnosisDetails) {
      // Handle navigation in your UI layer using routing
    } else if (event is NavigateToAddDiagnosis) {
      // Handle navigation in your UI layer using routing
    } else if (event is FilterPatientHistryQueues) {
      await filterQueues(event.query);
    }
  }

  Future<void> _fetchPatientHistory(int patientId) async {
    try {
      state = state.copywith(isLoading: true, error: null);

      final patient = await getPatientById(patientId);
      final allDiagnoses = await getAllDiagnoses();

      final patientDiagnoses = allDiagnoses
          .where((diagnosis) => diagnosis.patient.patientId == patientId)
          .toList();

      state = state.copywith(
        patient: patient,
        diagnosisList: patientDiagnoses,
        totalDiagnosis: patientDiagnoses.length,
        isLoading: false,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copywith(isLoading: false, error: e.toString());
    }
  }

  Future<void> filterQueues(String query) async {
    if (query.isEmpty) {
      await _fetchPatientHistory(state.patient?.patientId ?? 0);
      return;
    }
    final filteredQueues = state.diagnosisList.where((queue) {
      return queue.diagnosisName.toLowerCase().contains(query.toLowerCase());
    }).toList();
    state = state.copywith(diagnosisList: filteredQueues);
  }
}
