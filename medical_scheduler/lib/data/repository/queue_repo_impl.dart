// data/repositories/queue_repository_impl.dart
import 'package:medical_scheduler/data/model/RequestModel/queue_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/data/source/data_source/queue_data_src.dart';
import 'package:medical_scheduler/domain/repository/queue_repo.dart';

class QueueRepositoryImpl implements DataQueueRepository {
  final QueueDataSrc dataSource;

  QueueRepositoryImpl(this.dataSource);

  @override
  Future<List<DataQueue>> getAllQueues() async {
    return await dataSource.getAllQueues();
  }

  @override
  Future<DataQueue?> getDataQueuebyId(int id) async {
    return await dataSource.getQueueById(id);
  }

  @override
  Future<DataQueue> createQueue(QueueRequestModel queue) async {
    return await dataSource.createQueue(queue);
  }

  @override
  Future<void> updateQueue(int queueId, int status) async {
    await dataSource.updateQueue(queueId, status);
  }

  @override
  Future<void> deleteQueue(int id) async {
    await dataSource.deleteQueue(id);
  }
}
