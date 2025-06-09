import 'package:medical_scheduler/data/model/RequestModel/register_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/user_model.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

abstract class UserRepo {
  Future<List<User>> getAllUsers();
  Future<UserModel> updateUser(int userId, RegisterRequestModel user);
  Future<String> deleteUser(int id);
}
