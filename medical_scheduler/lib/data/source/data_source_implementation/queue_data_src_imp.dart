import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/model/queue_model.dart';
import 'package:medical_scheduler/data/source/data_source/queue_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';

class QueueDataSourceImpl implements QueueDataSrc {
  final Dio dio;

  QueueDataSourceImpl(this.dio);

  @override
  Future<List<DataQueueModel>> getAllQueues() async {
    try {
      final response = await dio.get('/queues');
      return (response.data as List)
          .map((e) => DataQueueModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load queues: $e');
    }
  }

  @override
  Future<DataQueueModel> getQueueById(int id) async {
    try {
      final response = await dio.get('/queues/$id');
      return DataQueueModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load queue with ID $id: $e');
    }
  }

  @override
  Future<void> createQueue(DataQueue queue) async {
    try {
      await dio.post('/queues', data: (queue as DataQueueModel).toJson());
    } catch (e) {
      throw Exception('Failed to create queue: $e');
    }
  }

  @override
  Future<void> updateQueue(int queueId, int status ) async {
    try {
      await dio.put('/queues/$queueId', data: {"status": status});
    } catch (e) {
      throw Exception('Failed to update queue with ID $queueId: $e');
    }
  }

  @override
  Future<void> deleteQueue(int id) async {
    try {
      await dio.delete('/queues/$id');
    } catch (e) {
      throw Exception('Failed to delete queue with ID $id: $e');
    }
  }
}
