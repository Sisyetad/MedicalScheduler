abstract class ReceptionistQueueEvent {}

class FetchReceptionistQueues extends ReceptionistQueueEvent {}

class UpdateReceptionistQueueStatus extends ReceptionistQueueEvent {
  final int queueId;
  final int status;
  UpdateReceptionistQueueStatus(this.queueId, this.status);
}

class FilterReceptionistQueues extends ReceptionistQueueEvent {
  final String query;
  FilterReceptionistQueues(this.query);
} 