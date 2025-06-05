import 'package:medical_scheduler/domain/entities/response/user.dart';

import '../entities/response/authresponse.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(String name, String email, String password, String role);
   Future<User> getUserProfile(String token);
  
}
