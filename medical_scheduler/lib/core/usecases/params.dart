// Authentication
import 'package:medical_scheduler/data/model/RequestModel/diagnosis_request_model.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/data/model/RequestModel/queue_request_model.dart';
import 'package:medical_scheduler/data/model/RequestModel/register_request_model.dart';
import 'package:medical_scheduler/domain/entities/request/login_request.dart';
import 'package:medical_scheduler/domain/entities/request/signup_request.dart';

class LoginParams {
  final LoginRequest loginRequest;

  LoginParams({required this.loginRequest});
}

class RegisterParams {
  final SignupRequest signupRequest;

  RegisterParams({required this.signupRequest});
}

class UpdateUserParams {
  final int userId;
  final RegisterRequestModel user;

  UpdateUserParams({required this.userId, required this.user});
}

//Queue management
class CreateQueueParams {
  final QueueRequestModel queueRequest;
  CreateQueueParams({required this.queueRequest});
}

class CreateDiagnosisParams {
  final DiagnosisRequestModel diagnosisRequest;

  CreateDiagnosisParams({required this.diagnosisRequest});
}

class UpdateQueueParams {
  final int queueId;
  final int status;

  UpdateQueueParams({required this.queueId, required this.status});
}

class CreateReceptionistParams {
  final EmployeeRequestModel receptionistRequest;

  CreateReceptionistParams({required this.receptionistRequest});
}

class CreateDoctorParams {
  final EmployeeRequestModel doctorRequest;

  CreateDoctorParams({required this.doctorRequest});
}
