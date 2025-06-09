import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:medical_scheduler/data/repository/patient_repo_imp.dart';
import 'package:medical_scheduler/data/source/data_source/patient_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/patient_data_src_imp.dart';
import 'package:medical_scheduler/domain/repository/patient_repo.dart';
import 'package:medical_scheduler/Application/Usecases/patient/getpatient.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Doctor/patient_history_view_model.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/diagnosis_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Doctor/patient_history_state.dart';

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

final getPatientByIdProvider = Provider<GetpatientById>((ref) {
  final repo = ref.watch(patientRepoProvider);
  return GetpatientById(repo);
});

final patientHistoryNotifierProvider =
    StateNotifierProvider<PatientHistoryNotifier, PatienthistoryUiState>((ref) {
      final getDiagnoses = ref.watch(displayDiagnoses);
      final getPatient = ref.watch(getPatientByIdProvider);

      return PatientHistoryNotifier(
        getAllDiagnoses: getDiagnoses,
        getPatientById: getPatient,
      );
    });
