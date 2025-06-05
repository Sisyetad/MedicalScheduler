// Authentication
import 'package:medical_scheduler/data/model/diagnosis_request_model.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String name;
  final String password;
  final String role;

  RegisterParams({
    required this.name,
    required this.password,
    required this.role,
  });
}

// User Management
class CreateUserParams {
  final String name;
  final String email;
  final int branchInt;

  CreateUserParams({
    required this.name,
    required this.email,
    required this.branchInt,
  });
}

class UpdateUserParams {
  final String userName;
  final String email;
  final String password;

  UpdateUserParams({
    required this.userName,
    required this.email,
    required this.password,
  });
}

//Queue management
class CreateQueueParams {}

class CreateDiagnosisParams {
  final DiagnosisRequestModel diagnosisRequest;

  CreateDiagnosisParams({
    required this.diagnosisRequest
  });
}

class UpdateQueueParams {
  final int queueId;
  final int status;

  UpdateQueueParams({required this.queueId, required this.status});
}
