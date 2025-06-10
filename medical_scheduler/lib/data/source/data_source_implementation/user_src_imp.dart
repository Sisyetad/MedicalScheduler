import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/model/RequestModel/register_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/user_model.dart';
import 'package:medical_scheduler/data/source/data_source/user_src.dart';

class UserSrcImp extends UserSrc {
  final Dio dio;
  UserSrcImp(this.dio);

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await dio.get('/users');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
        'Failed to load users: ${response.statusCode} - ${response.statusMessage}',
      );
    }
  }

  @override
  Future<UserModel> updateUser(int userId, RegisterRequestModel user) async {
    final response = await dio.put('/users/$userId', data: user.toJson());

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception(
        'Failed to update user: ${response.statusCode} - ${response.statusMessage}',
      );
    }
  }

  @override
  Future<String> deleteUser(int id) async {
    final response = await dio.delete('/users/delete/$id');

    if (response.statusCode == 204 || response.statusCode == 200) {
      return 'User deleted successfully';
    } else {
      throw Exception(
        'Failed to delete user: ${response.statusCode} - ${response.statusMessage}',
      );
    }
  }
}
