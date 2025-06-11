import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/domain/repository/queue_repo.dart';

class CreateQueue extends UseCase<DataQueue, CreateQueueParams> {
  final DataQueueRepository dataQueueRepository;
  CreateQueue(this.dataQueueRepository);

  @override
  Future<DataQueue> call(CreateQueueParams params) {
    return dataQueueRepository.createQueue(params.queueRequest);
  }
}
