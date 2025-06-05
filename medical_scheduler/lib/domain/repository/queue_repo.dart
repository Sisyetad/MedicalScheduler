import 'package:medical_scheduler/domain/entities/response/queue.dart';

abstract class DataQueueRepository {
  Future<DataQueue?> getDataQueuebyId(int queueId);
  Future<List<DataQueue>> getAllQueues();
  Future<void> updateQueue( int queueId, int status);
}
