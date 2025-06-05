import 'package:medical_scheduler/domain/entities/request/login_request.dart';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromEntity(LoginEntity entity) {
    return LoginRequestModel(email: entity.email, password: entity.password);
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
