import 'package:medical_scheduler/data/model/user_model.dart';

import '../../../domain/entities/response/authresponse.dart';

abstract class AuthDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    String role,
  );
  Future<UserModel> getUserProfile(String token);
}
