import 'package:medical_scheduler/domain/entities/response/user.dart';

class Patient extends User {
  final int patientId;
  final String address;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;
  final String firstName;
  final String lastName;
  final User? registeredBy;

  Patient({
    required this.patientId,
    super.username,
    required super.email,
    required super.password,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    this.registeredBy,
  }):super(userId: patientId);

  @override
  Patient copyWith({
    String? username,
    String? email,
    String? password,
    String? updatedAt,
    String? newPhone,
    String? newAddress,
    String? gender,
    String? dateOfBirth,
    String? firstName,
    String? lastName,
    User? registeredBy,
  }) {
    return Patient(
      patientId: patientId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? "",
      address: newAddress ?? address,
      phoneNumber: newPhone ?? phoneNumber,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now().toIso8601String(),
      role: role,
      registeredBy: registeredBy ?? this.registeredBy,
    );
  }

}
