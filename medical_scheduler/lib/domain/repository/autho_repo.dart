import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

import '../entities/response/authresponse.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    Role role,
  );
  Future<User> getUserProfile(String token);
}
