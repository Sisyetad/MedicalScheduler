import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/repository/user_repo.dart';

class GetAllUsers {
  final UserRepo userRepo;

  GetAllUsers(this.userRepo);
  Future<List<User>> call() async {
    return await userRepo.getAllUsers();
  }
}
