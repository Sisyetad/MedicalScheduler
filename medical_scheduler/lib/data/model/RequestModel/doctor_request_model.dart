import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';

class EmployeeRequestModel extends EmployeeRequest {
  EmployeeRequestModel({
    super.username,
    required super.email,
    required super.branchId,
  });

  Map<String, dynamic> toJson() {
    return {'name': username, 'email': email, 'branch_id': branchId};
  }
}
