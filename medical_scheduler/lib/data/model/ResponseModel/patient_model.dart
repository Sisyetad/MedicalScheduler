import 'package:medical_scheduler/data/model/ResponseModel/role_model.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/data/model/ResponseModel/branch_model.dart';

class PatientModel extends Patient {
  PatientModel({
    required super.patientId,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.email,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
    required super.address,
    required super.dateOfBirth,
    required super.gender,
    required super.phoneNumber,
    super.registeredBy,
  }) : super(role: RoleModel(roleId: 3, name: 'Patient'));

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      patientId: json['patient_id'] ?? json['user_id'],
      username: '${json['first_name']} ${json['last_name']}',
      email: json['email'],
      password: json['password'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      phoneNumber: json['phone_number'],
      registeredBy: json['registered_by'] != null
          ? BranchModel.fromJson(json['registered_by'])
          : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'address': address,
      'password': passwordHash,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'registered_by': registeredBy != null
          ? (registeredBy as BranchModel).toJson()
          : null, // Assuming registeredBy is a BranchModel
    };
  }
}
