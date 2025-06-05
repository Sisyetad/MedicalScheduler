class PatientRequest {
  final String firstName;
  final String lastName;
  final String? email;
  final String phone;
  final String dateofBirth;
  final String gender;
  final String? address;
  final int registeredby;

  PatientRequest({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateofBirth,
    this.address,
    this.email,
    required this.phone,
    required this.registeredby,
  });
}
