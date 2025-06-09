import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/repository/queue_repo.dart';

class UpdateQueue extends UseCase<void, UpdateQueueParams> {
  final DataQueueRepository repository;

  UpdateQueue(this.repository);

  @override
  Future<void> call(UpdateQueueParams params) {
    return repository.updateQueue(params.queueId, params.status);
  }
}
