// domain/usecases/auth/register_user.dart

import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/authresponse.dart';
import 'package:medical_scheduler/domain/repository/autho_repo.dart';

class RegisterUseCase extends UseCase<AuthResponse, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<AuthResponse> call(RegisterParams params) {
    return repository.register(
      params.signupRequest.name,
      params.signupRequest.email,
      params.signupRequest.password,
      params.signupRequest.role
    );
  }
}