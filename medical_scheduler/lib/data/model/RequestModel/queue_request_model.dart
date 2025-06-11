import 'package:medical_scheduler/domain/entities/request/queue_request.dart';

class QueueRequestModel extends QueueRequest {
  QueueRequestModel({required super.patientId});

  Map<String, dynamic> toJson() {
    return {'patient_id': patientId, 'status': 1};
  }
}
