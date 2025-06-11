import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medical_scheduler/Application/Usecases/profile/update_profile.dart';
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/edit_profile_ui_state.dart';
import 'package:medical_scheduler/presentation/events/Auth/profile_edit_event.dart';
class EditProfileViewModel extends StateNotifier<EditProfileUiState> {
  final UpdateProfile updateProfileUseCase;
  final GetUserUseCase getUserUseCase;
  final storage = FlutterSecureStorage();

  EditProfileViewModel(this.updateProfileUseCase, this.getUserUseCase)
      : super(EditProfileUiState());

  void onEvent(ProfileEditEvent event) {
    if (event is UpdateUserName) {
      state = state.copyWith(username: event.username, error: null);
    } else if (event is UpdateEmail) {
      state = state.copyWith(email: event.email, error: null);
    } else if (event is UpdateCurrentPassword) {
      state = state.copyWith(currentPassword: event.currentPassword, error: null);
    } else if (event is UpdateNewPassword) {
      state = state.copyWith(newPassword: event.newPassword, error: null);
    } else if (event is UpdateConfirmPassword) {
      state = state.copyWith(confirmPassword: event.confirmPassword, error: null);
    } else if (event is SubmitProfileUpdate) {
      _submitProfileUpdate(
        username: event.username,
        email: event.email,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
    }
  }

  Future<void> _submitProfileUpdate({
    required String username,
    required String email,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception("User not logged in");

      final request = UpdateProfileRequest(
        username: username,
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      await updateProfileUseCase.call(UpdateUserParams());

      final user = await getUserUseCase.call(token);

      state = state.copyWith(isLoading: false, isSuccess: true, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadUserProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception("No auth token found");

      final user = await getUserUseCase.call(token);
      state = state.copyWith(
        isLoading: false,
        user: user,
        username: user.name,
        email: user.email,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
