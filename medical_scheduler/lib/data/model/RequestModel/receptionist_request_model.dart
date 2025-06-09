import 'package:medical_scheduler/domain/entities/request/receptionist_request.dart';

class ReceptionistRequestModel extends ReceptionistRequest {
  ReceptionistRequestModel({required super.email, required super.branchId});

  factory ReceptionistRequestModel.fromJson(Map<String, dynamic> json) {
    return ReceptionistRequestModel(
      email: json['email'],
      branchId: json['branchId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'email': email, 'branchId': branchId};
  }
}
