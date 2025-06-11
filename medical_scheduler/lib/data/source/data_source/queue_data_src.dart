import 'package:medical_scheduler/data/model/RequestModel/queue_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';

abstract class QueueDataSrc {
  Future<List<DataQueue>> getAllQueues();
  Future<DataQueue?> getQueueById(int id);
  Future<DataQueue> createQueue(QueueRequestModel queue);
  Future<void> updateQueue(int queueId, int status);
  Future<void> deleteQueue(int id);
}
