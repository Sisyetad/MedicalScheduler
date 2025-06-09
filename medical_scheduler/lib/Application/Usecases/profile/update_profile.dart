import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/repository/user_repo.dart';

class UpdateProfile extends UseCase<User, UpdateUserParams> {
  final UserRepo userRepo;

  UpdateProfile(this.userRepo);

  @override
  Future<User> call(UpdateUserParams params) {
    return userRepo.updateUser(params.userId, params.user);
  }
}
