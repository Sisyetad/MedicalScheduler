import 'package:medical_scheduler/domain/entities/request/queue_request.dart';

class QueueRequestModel extends QueueRequest {
  QueueRequestModel({
    required super.doctorId,
    required super.patientId,
    required super.status,
  });

  Map<String, dynamic> toJson() {
    return {'doctor_id': doctorId, 'patient_id': patientId, 'status': status};
  }
}
