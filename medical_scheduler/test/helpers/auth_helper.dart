import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/login_request.dart';
// import 'package:medical_scheduler/data/source/data_source/auth_data_src.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/auth_data_src_impl.dart';
import 'package:dio/dio.dart';

class AuthHelper {
  static Future<String> loginAsDoctor() async {
    final dio = Dio();
    final authDataSource = AuthDataSourceImpl(dio);

    final loginRequest = LoginRequest(
      email: 'doctor1@medicare.com',
      password: '',
    );

    try {
      final response = await authDataSource.login(
        loginRequest.email,
        loginRequest.password,
      );
      return response.token;
    } catch (e) {
      fail('Failed to login as doctor: $e');
    }
  }

  static Future<String> loginAsReceptionist() async {
    final dio = Dio();
    final authDataSource = AuthDataSourceImpl(dio);

    final loginRequest = LoginRequest(
      email:
          'receptionist@test.com', // Replace with test receptionist credentials
      password: 'test123', // Replace with test receptionist credentials
    );

    try {
      final response = await authDataSource.login(
        loginRequest.email,
        loginRequest.password,
      );
      return response.token;
    } catch (e) {
      fail('Failed to login as receptionist: $e');
    }
  }

  static Future<String> loginAsAdmin() async {
    final dio = Dio();
    final authDataSource = AuthDataSourceImpl(dio);

    final loginRequest = LoginRequest(
      email: 'admin@test.com', // Replace with test admin credentials
      password: 'test123', // Replace with test admin credentials
    );

    try {
      final response = await authDataSource.login(
        loginRequest.email,
        loginRequest.password,
      );
      return response.token;
    } catch (e) {
      fail('Failed to login as admin: $e');
    }
  }

  static Dio getAuthenticatedDio(String token) {
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    return dio;
  }
}
