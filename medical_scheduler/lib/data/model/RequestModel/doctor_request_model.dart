import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';

class DoctorRequestModel extends DoctorRequest {
  DoctorRequestModel({
    required super.username,
    required super.email,
    required super.branchId,
  });

  factory DoctorRequestModel.fromJson(Map<String, dynamic> json) {
    return DoctorRequestModel(
      username: json['username'] as String,
      email: json['email'] as String,
      branchId: json['branchId'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'branchId': branchId};
  }
}
