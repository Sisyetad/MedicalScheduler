import 'package:medical_scheduler/domain/repository/user_repo.dart';

class DeleteUser {
  final UserRepo userRepository;
  DeleteUser(this.userRepository);

  Future<String> call(int userId) async {
    return await userRepository.deleteUser(userId);
  }
}
