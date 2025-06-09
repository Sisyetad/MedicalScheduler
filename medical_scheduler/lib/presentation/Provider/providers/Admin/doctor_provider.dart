import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:medical_scheduler/data/repository/doctor_repo_imp.dart';
import 'package:medical_scheduler/data/source/data_source/doctor_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/doctor_data_src_imp.dart';
import 'package:medical_scheduler/domain/repository/doctor_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
// Data Source
final doctorDataSourceProvider = Provider<DoctorDataSrc>(
  (ref) => DoctorDataSourceImpl(ref.watch(dioProvider)),
);

// Repository
final doctorRepositoryProvider = Provider<DoctorRepository>(
  (ref) => DoctorRepositoryImpl(ref.watch(doctorDataSourceProvider)),
);


