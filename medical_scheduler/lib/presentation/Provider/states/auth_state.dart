import 'package:medical_scheduler/domain/entities/response/user.dart';

class AuthUiState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String email;
  final String password;
  final User? user;

  AuthUiState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.email = '',
    this.password = '',
    this.user
  });

  AuthUiState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? email,
    String? password,
    User? user,
  }) {
    return AuthUiState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user?? this.user
    );
  }
}
