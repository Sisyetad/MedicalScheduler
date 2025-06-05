// domain/usecases/auth/login_user.dart
import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/authresponse.dart';
import 'package:medical_scheduler/domain/repository/autho_repo.dart';


class LoginUseCase extends UseCase<AuthResponse, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<AuthResponse> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}
