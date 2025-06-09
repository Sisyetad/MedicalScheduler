import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/Application/Usecases/auth/login.dart';
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart';
import 'package:medical_scheduler/data/model/RequestModel/login_request_model.dart';
import 'package:medical_scheduler/domain/entities/request/login_request.dart';
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthViewModel extends StateNotifier<AuthUiState> {
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final storage = FlutterSecureStorage();

  AuthViewModel(this.loginUseCase, this.getUserUseCase) : super(AuthUiState());

  void onEvent(AuthEvent event) {
    if (event is UpdateEmail) {
      state = state.copyWith(email: event.email, error: null);
    } else if (event is UpdatePassword) {
      state = state.copyWith(password: event.password, error: null);
    } else if (event is SubmitLogin) {
      _loginUser(event.context);
    } else if (event is Logout) {
      logout();
    }
  }

  Future<void> _loginUser(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await loginUseCase.call(
        LoginParams(
          loginRequest:
              LoginRequestModel(email: state.email, password: state.password)
                  as LoginRequest,
        ),
      );

      await storage.write(key: 'auth_token', value: token.token);
      final user = await getUserUseCase.call(token.token);
      state = state.copyWith(isLoading: false, isSuccess: true, user: user);
      _navigateBasedOnRole(context, user.role.roleId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    state = state.copyWith(isLoading: true);

    try {
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        state = state.copyWith(isLoading: false);
        context.go('/auth');
        return;
      }

      final user = await getUserUseCase.call(token);
      state = state.copyWith(user: user, isLoading: false);
      _navigateBasedOnRole(context, user.role.roleId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      context.go('/auth');
    }
  }

  Future<void> logout() async {
    try {
      await storage.delete(key: 'auth_token');
    } catch (e) {
      print("Error during logout: $e");
    } finally {
      state = AuthUiState();
    }
  }

  void _navigateBasedOnRole(BuildContext context, int roleId) {
    switch (roleId) {
      case 4:
        context.go('/doctor_queue');
        break;
      case 5:
        context.go('/receptionist_home');
        break;
      case 2:
        context.go('/admin_home');
        break;
      default:
        context.go('/auth');
    }
  }
}
