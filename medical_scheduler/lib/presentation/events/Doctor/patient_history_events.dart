abstract class PatientHistoryEvent {}

class FetchPatientHistory extends PatientHistoryEvent {
  final int patientId;
  FetchPatientHistory(this.patientId);
}

class NavigateToDiagnosisDetails extends PatientHistoryEvent {
  final int diagnosisId;
  NavigateToDiagnosisDetails(this.diagnosisId);
}

class NavigateToAddDiagnosis extends PatientHistoryEvent {}

class FilterPatientHistryQueues extends PatientHistoryEvent {
  final String query;
  FilterPatientHistryQueues(this.query);
}
