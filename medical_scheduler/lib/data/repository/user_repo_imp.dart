import 'package:medical_scheduler/data/model/RequestModel/register_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/user_model.dart';
import 'package:medical_scheduler/data/source/data_source/user_src.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/repository/user_repo.dart';

class UserRepoImp extends UserRepo {
  final UserSrc userSource;
  UserRepoImp(this.userSource);

  @override
  Future<List<User>> getAllUsers() {
    return userSource.getAllUsers();
  }

  @override
  Future<UserModel> updateUser(int userId, RegisterRequestModel user) {
    return userSource.updateUser(userId, user);
  }

  @override
  Future<String> deleteUser(int id) {
    return userSource.deleteUser(id);
  }
}
