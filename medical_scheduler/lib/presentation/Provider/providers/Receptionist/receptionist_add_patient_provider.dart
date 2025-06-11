import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/patient/add_patient.dart';
import 'package:medical_scheduler/Application/Usecases/queue/add_queue.dart';
import 'package:medical_scheduler/domain/repository/patient_repo.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Receptionist/receptionist_add_patient_notifier.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/queue_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Receptionist/receptionist_add_patient_state.dart';
import 'package:medical_scheduler/data/repository/patient_repo_imp.dart';
import 'package:medical_scheduler/data/source/data_source/patient_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/patient_data_src_imp.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:dio/dio.dart';

final sessionManagerProvider = Provider((ref) => SecureSessionManager());

final dioClientProvider = Provider<DioClient>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return DioClient(sessionManager);
});

final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});

final patientDataSrcProvider = Provider<PatientDataSrc>((ref) {
  final dio = ref.watch(dioProvider);
  return PatientDataSourceImpl(dio);
});

final patientRepoProvider = Provider<PatientRepository>((ref) {
  final remote = ref.watch(patientDataSrcProvider);
  return PatientRepositoryImpl(remote);
});

final createPatientUseCaseProvider = Provider<CreatePatient>((ref) {
  final repo = ref.watch(patientRepoProvider);
  return CreatePatient(repo);
});

final createQueueUsecaseProvider = Provider<CreateQueue>((ref) {
  final repo = ref.watch(queueRepoProvider);
  return CreateQueue(repo);
});

final receptionistAddPatientNotifierProvider =
    StateNotifierProvider<
      ReceptionistAddPatientNotifier,
      ReceptionistAddPatientState
    >((ref) {
      final createPatientUseCase = ref.watch(createPatientUseCaseProvider);
      final createQueueUseCase = ref.watch(createQueueUsecaseProvider);
      return ReceptionistAddPatientNotifier(
        createPatientUseCase,
        createQueueUseCase,
      );
    });
