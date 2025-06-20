import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/source/data_source/queue_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/queue_data_src_imp.dart';
import 'package:medical_scheduler/data/repository/queue_repo_impl.dart';
import 'package:medical_scheduler/domain/repository/queue_repo.dart';
import 'package:medical_scheduler/Application/Usecases/queue/getQueues.dart';
import 'package:medical_scheduler/Application/Usecases/queue/update_queue.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Receptionist/receptionist_queue_notifier.dart';
import 'package:medical_scheduler/presentation/Provider/states/Common/queue_state.dart';

final sessionManagerProvider = Provider((ref) => SecureSessionManager());

final dioClientProvider = Provider<DioClient>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return DioClient(sessionManager);
});

final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});

final queueDatasrcProvider = Provider<QueueDataSrc>((ref) {
  final dio = ref.watch(dioProvider);
  return QueueDataSourceImpl(dio);
});

final queueRepoProvider = Provider<DataQueueRepository>((ref) {
  final remote = ref.watch(queueDatasrcProvider);
  return QueueRepositoryImpl(remote);
});

final updateQueueUsecaseProvider = Provider<UpdateQueue>((ref) {
  final repo = ref.watch(queueRepoProvider);
  return UpdateQueue(repo);
});

final getQueuesUsecaseProvider = Provider<GetAllQueues>((ref) {
  final repo = ref.watch(queueRepoProvider);
  return GetAllQueues(repo);
});

final receptionistQueueNotifierProvider =
    StateNotifierProvider<ReceptionistQueueNotifier, QueueUiState>((ref) {
  final updateQueueUseCase = ref.watch(updateQueueUsecaseProvider);
  final getAllQueueUsecase = ref.watch(getQueuesUsecaseProvider);
  return ReceptionistQueueNotifier(updateQueueUseCase, getAllQueueUsecase);
}); 