import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/model/RequestModel/login_request_model.dart';
import 'package:medical_scheduler/data/model/RequestModel/register_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/user_model.dart';
import 'package:medical_scheduler/data/source/data_source/authDataSrc.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import '../../../domain/entities/response/authresponse.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl(this.dio);

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/users/login',
        data: LoginRequestModel(email: email, password: password).toJson(),
      );

      final data = response.data;
      return AuthResponse(token: data['token']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Login failed: ${e.response?.data['message'] ?? 'Unknown error'}',
        );
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    }
  }

  @override
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    Role role,
  ) async {
    try {
      String roleName = role.name.toLowerCase();
      if (roleName == "branch") {
        roleName = 'branche';
      }
      final response = await dio.post(
        '/users/${roleName}s/signup/$email',
        data: SignUpBodyModel(name: name, password: password).toJson(),
      );

      final data = response.data;
      return AuthResponse(token: data['token']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Registration failed: ${e.response?.data['message'] ?? e.message}',
        );
      } else {
        throw Exception('Registration failed: ${e.message}');
      }
    }
  }

  @override
  Future<UserModel> getUserProfile(String token) async {
    final response = await dio.get(
      '/users/user',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception(
        'Failed to load profile: ${response.statusCode} - ${response.statusMessage}',
      );
    }
  }
}
