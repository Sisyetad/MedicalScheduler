import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/profile/update_profile.dart';
import 'package:medical_scheduler/core/network/dio_client.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';
import 'package:medical_scheduler/data/repository/user_repo_imp.dart';
import 'package:medical_scheduler/data/source/data_source/user_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/user_src_imp.dart';
import 'package:medical_scheduler/domain/repository/user_repo.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Auth/edit_profile_view_model.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/edit_profile_ui_state.dart';

final sessionManagerProvider = Provider((ref) => SecureSessionManager());

final dioClientProvider = Provider<DioClient>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return DioClient(sessionManager);
});

final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});

final authDataSourceProvider = Provider<UserSrc>((ref) {
  final dio = ref.watch(dioProvider);
  return UserSrcImp(dio);
});

final authRepositoryProvider = Provider<UserRepo>((ref) {
  final remote = ref.watch(authDataSourceProvider);
  return UserRepoImp(remote);
});

final updateProfileUseCaseProvider = Provider<UpdateProfile>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return UpdateProfile(repo);
});

final editProfileViewModelProvider =
    StateNotifierProvider<EditProfileViewModel, EditProfileUiState>(
      (ref) => EditProfileViewModel(
        ref.read(updateProfileUseCaseProvider),
        ref.read(getUserUsecaseProvider),
      ),
    );
