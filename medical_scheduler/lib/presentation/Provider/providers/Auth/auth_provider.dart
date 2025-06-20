import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/auth/signUp.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:medical_scheduler/data/repository/auth_repo_imp.dart';
import 'package:medical_scheduler/data/source/data_source/authDataSrc.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/auth_data_src_impl.dart';
import 'package:medical_scheduler/domain/repository/autho_repo.dart';
import 'package:medical_scheduler/Application/Usecases/auth/login.dart';
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Auth/auth_view_model.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';

final sessionManagerProvider = Provider((ref) => SecureSessionManager());

final dioClientProvider = Provider<DioClient>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return DioClient(sessionManager);
});

final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthDataSourceImpl(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(remote);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginUseCase(repo);
});

final getUserUsecaseProvider = Provider<GetUserUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return GetUserUseCase(repo);
});

final signUpUsecaseProvider = Provider<RegisterUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repo);
});

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthUiState>(
  (ref) {
    final loginUseCase = ref.watch(loginUseCaseProvider);
    final getUserUseCase = ref.watch(getUserUsecaseProvider);
    final signUpUsecase = ref.watch(signUpUsecaseProvider);
    return AuthViewModel(loginUseCase, getUserUseCase, signUpUsecase);
  },
);
