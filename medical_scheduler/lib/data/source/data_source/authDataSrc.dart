import 'package:medical_scheduler/data/model/ResponseModel/user_model.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

import '../../../domain/entities/response/authresponse.dart';

abstract class AuthDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    Role role,
  );
  Future<UserModel> getUserProfile(String token);
}
