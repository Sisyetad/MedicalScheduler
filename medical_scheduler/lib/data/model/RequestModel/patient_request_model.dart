import 'package:medical_scheduler/domain/entities/request/patient_request.dart';

class PatientRequestModel extends PatientRequest {
  PatientRequestModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.address,
    required super.dateofBirth,
    required super.gender,
    required super.registeredby,
  });

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone_number': phone,
    'address': address,
    'date_of_birth': dateofBirth,
    'registered_by': registeredby,
    'gender': gender,
  };
}
