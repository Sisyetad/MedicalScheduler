import 'package:medical_scheduler/domain/entities/response/queue.dart';


abstract class QueueDataSrc {
  Future<List<DataQueue>> getAllQueues();
  Future<DataQueue?> getQueueById(int id);
  Future<void> createQueue(DataQueue queue);
  Future<void> updateQueue(int queueId, int status);
  Future<void> deleteQueue(int id);
}
