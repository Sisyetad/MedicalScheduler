import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/domain/repository/queue_repo.dart';

class Viewpatienthistory {
  final DataQueueRepository repository;

  Viewpatienthistory(this.repository);
  
  Future<DataQueue?> call(int queueId) {
    return repository.getDataQueuebyId(queueId);
  }
}
