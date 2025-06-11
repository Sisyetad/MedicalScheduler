import 'package:medical_scheduler/domain/entities/request/signup_request.dart';

class RegisterRequestModel extends SignupRequest {
  RegisterRequestModel({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() => {
    'username': name,
    'email': email,
    'password': password,
  };
}

class SignUpBodyModel extends SignupBody {
  SignUpBodyModel({
    required super.name,
    required super.password,
    super.location,
    super.speciality,
    super.role,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
    'location': location ?? "",
    'speciality': speciality ?? "",
    'role': role?.name.toLowerCase(),
  };
}
