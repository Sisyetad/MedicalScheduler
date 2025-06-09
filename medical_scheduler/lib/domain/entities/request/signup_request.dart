import 'package:medical_scheduler/domain/entities/response/role.dart';

class SignupRequest {
  final String email;
  final String name;
  final String password;
  final String? location;
  final String? speciality;
  final Role role;

  SignupRequest({
    required this.email,
    required this.name,
    required this.password,
    this.location,
    this.speciality,
    required this.role,
  });
}

class SignupBody {
  final String name;
  final String password;
  final String? location;
  final String? speciality;
  final Role? role;

  SignupBody({
    required this.name,
    required this.password,
    this.location,
    this.speciality,
    this.role,
  });
}
