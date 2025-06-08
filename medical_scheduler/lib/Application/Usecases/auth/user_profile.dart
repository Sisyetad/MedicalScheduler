import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/repository/autho_repo.dart';

class GetUserUseCase {
  final AuthRepository repository;
  GetUserUseCase(this.repository);

  Future<User> call(String token) {
    return repository.getUserProfile(token);
  }
}
