class QueueRequest {
  final int patientId;
  final int doctorId;
  final int status;

  QueueRequest({
    required this.doctorId,
    required this.patientId,
    required this.status,
  });
}