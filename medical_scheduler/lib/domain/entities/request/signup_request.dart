class SignupRequest {
  final String email;
  final String name;
  final String password;
  final String? location;
  final String? speciality;

  SignupRequest({
    required this.email,
    required this.name,
    required this.password,
    this.location,
    this.speciality,
  });
}


class SignupBody {
  final String name;
  final String password;
  final String? location;
  final String? speciality;

  SignupBody({
    required this.name,
    required this.password,
    this.location,
    this.speciality,
  });
}