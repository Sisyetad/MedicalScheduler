class DiagnosisRequest {
  final String diagnosisName;
  final int patientId;
  final int doctorId;
  final bool visible;
  final String medication;
  final String comment;

  DiagnosisRequest({
    required this.comment,
    required this.diagnosisName,
    required this.doctorId,
    required this.medication,
    required this.patientId,
    required this.visible,
  });

}
