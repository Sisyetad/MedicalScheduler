import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/auth/signUp.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/Application/Usecases/auth/login.dart';
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart';
import 'package:medical_scheduler/data/model/RequestModel/login_request_model.dart';
import 'package:medical_scheduler/domain/entities/request/login_request.dart';
import 'package:medical_scheduler/domain/entities/request/signup_request.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthViewModel extends StateNotifier<AuthUiState> {
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final RegisterUseCase registerUseCase;
  final storage = FlutterSecureStorage();

  AuthViewModel(this.loginUseCase, this.getUserUseCase, this.registerUseCase) : super(AuthUiState());

  void onEvent(AuthEvent event) {
    if (event is UpdateEmail) {
      if (state.email != event.email) {
        state = state.copyWith(email: event.email, error: null);
      }
    } else if (event is UpdatePassword) {
      if (state.password != event.password) {
        state = state.copyWith(password: event.password, error: null);
      }
    } else if (event is UpdateName){
      if (state.name != event.username) {
        state = state.copyWith(name: event.username, error: null);
      }
    }
     else if (event is SubmitLogin) {
      _loginUser(event.email, event.password);
    } else if (event is Logout) {
      logout();
    } else if (event is SubmitSignup){

    }
  }
  
Future<void> registerUser({
  required String username,
  required String email,
  required String password,
  required String role,
}) async {
  state = state.copyWith(isLoading: true, error: null);
  try {
    final roleObject = _mapStringToRole(role);
    final token = await registerUseCase.call(
      RegisterParams(
        signupRequest: SignupRequest(
          email: email,
          name: username,
          password: password,
          role: roleObject,
        ),
      ),
    );
    await storage.write(key: 'auth_token', value: token.token); // Store token
    final user = await getUserUseCase.call(token.token); // Fetch user
    state = state.copyWith(isLoading: false, isSuccess: true, user: user); // Update state with user
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
  }
}

Role _mapStringToRole(String role) {
  switch (role.toLowerCase()) {
    case 'patient':
      return Role(roleId: 1, name: 'patient');
    case 'doctor':
      return Role(roleId: 2, name: 'doctor');
    case 'admin':
      return Role(roleId: 3, name: 'admin');
    default:
      throw Exception('Invalid role: $role');
  }
}
  

  Future<void> _loginUser(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await loginUseCase.call(
        LoginParams(
          loginRequest:
              LoginRequestModel(email: email, password: password)
                  as LoginRequest,
        ),
      );
      await storage.write(key: 'auth_token', value: token.token);
      final user = await getUserUseCase.call(token.token);
      state = state.copyWith(isLoading: false, isSuccess: true, user: user);
      // No navigation here!
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkLoginStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) {
        state = state.copyWith(isLoading: false, user: null);
        return;
      }
      final user = await getUserUseCase.call(token);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), user: null);
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
}


