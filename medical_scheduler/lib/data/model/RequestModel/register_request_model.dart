import 'package:medical_scheduler/domain/entities/request/signup_request.dart';

class RegisterRequestModel extends SignupRequest {
  RegisterRequestModel({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'role': role,
  };
}
