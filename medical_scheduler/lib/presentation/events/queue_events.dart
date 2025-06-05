abstract class DoctorQueueEvent {}

class FetchQueues extends DoctorQueueEvent {}

class UpdateQueueStatus extends DoctorQueueEvent {
  final int queueId;
  final int status;
  UpdateQueueStatus(this.queueId, this.status);
}
