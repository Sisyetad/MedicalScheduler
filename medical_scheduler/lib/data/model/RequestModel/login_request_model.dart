import 'package:medical_scheduler/domain/entities/request/login_request.dart';

class LoginRequestModel extends LoginRequest {
  LoginRequestModel({required super.email, required super.password});

  factory LoginRequestModel.fromEntity(LoginRequest entity) {
    return LoginRequestModel(email: entity.email, password: entity.password);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
