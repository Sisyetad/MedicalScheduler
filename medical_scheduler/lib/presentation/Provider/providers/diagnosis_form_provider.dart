import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:medical_scheduler/data/repository/diagnosis_repo_impl.dart';
import 'package:medical_scheduler/data/source/data_source/diagnosis_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/diagnosis_data_src_imp.dart';
import 'package:medical_scheduler/domain/repository/diagnosis_repo.dart';
import 'package:medical_scheduler/domain/usecases/doctor/createDiagnosis.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/diagnosis_form_viewmodel.dart';
import 'package:medical_scheduler/presentation/Provider/states/diagnosis_form_state.dart';

final sessionManagerProvider = Provider((ref) => SecureSessionManager());

final dioClientProvider = Provider<DioClient>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return DioClient(sessionManager);
});

final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});

final diagnosisDataScrProvider = Provider<DiagnosisDataSrc>((ref) {
  final dio = ref.watch(dioProvider);
  return DiagnosisDataSrcImpl(dio: dio);
});

final diagnosisRepoProvider = Provider<DiagnosisRepository>((ref) {
  final remote = ref.watch(diagnosisDataScrProvider);
  return DiagnosisRepositoryImpl(remote);
});

final diagnosisUsecaseProvider = Provider<CreateDiagnosis>((ref) {
  final repo = ref.watch(diagnosisRepoProvider);
  return CreateDiagnosis(repo);
});



final diagnosisFormNotifierProvider =
    StateNotifierProvider<DiagnosisFormNotifier, DiagnosisFormState>((ref) {
  final useCase = ref.watch(diagnosisUsecaseProvider);
  return DiagnosisFormNotifier(useCase);
});
