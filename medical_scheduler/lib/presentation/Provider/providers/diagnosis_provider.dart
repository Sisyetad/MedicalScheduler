import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:medical_scheduler/data/repository/diagnosis_repo_impl.dart';
import 'package:medical_scheduler/data/source/data_source/diagnosis_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/diagnosis_data_src_imp.dart';
import 'package:medical_scheduler/domain/repository/diagnosis_repo.dart';
import 'package:medical_scheduler/domain/usecases/doctor/displayDiagnoses.dart';
import 'package:medical_scheduler/domain/usecases/doctor/getDiagnosis.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/diagnosis_detail_viewmodel.dart';
import 'package:medical_scheduler/presentation/Provider/states/diagnosis_detail_state.dart';

final sessionManagerProvider = Provider((ref) => SecureSessionManager());

final dioClientProvider = Provider<DioClient>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return DioClient(sessionManager);
});

final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});

final diagnosisDataSourceProvider = Provider<DiagnosisDataSrc>((ref) {
  final dio = ref.watch(dioProvider);
  return DiagnosisDataSrcImpl(dio: dio);
});

// Repository
final diagnosisRepositoryProvider = Provider<DiagnosisRepository>(
  (ref) => DiagnosisRepositoryImpl(ref.watch(diagnosisDataSourceProvider)),
);

final displayDiagnoses = Provider<GetAllDiagnoses>((ref) {
  final repo = ref.watch(diagnosisRepositoryProvider);
  return GetAllDiagnoses(repo);
});


final displayDiagnosis = Provider<GetDiagnosisById>((ref) {
  final repo = ref.watch(diagnosisRepositoryProvider);
  return GetDiagnosisById(repo);
});


final diagnosisDetailNotifierProvider =
    StateNotifierProvider<DiagnosisDetailNotifier, DiagnosisDetailUiState>((ref) {
  final getDiagnosis = ref.watch(displayDiagnosis);
  return DiagnosisDetailNotifier(getDiagnosisById: getDiagnosis);
});
