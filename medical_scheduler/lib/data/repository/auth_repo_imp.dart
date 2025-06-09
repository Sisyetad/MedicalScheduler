import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

import '../../domain/entities/response/authresponse.dart';
import '../../../domain/repository/autho_repo.dart';
import '../source/data_source/authDataSrc.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<AuthResponse> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    Role role,
  ) {
    return dataSource.register(name, email, password, role);
  }

  @override
  Future<User> getUserProfile(String token) {
    return dataSource.getUserProfile(token);
  }
}
