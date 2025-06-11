import 'package:medical_scheduler/data/model/RequestModel/queue_request_model.dart';

abstract class AddPatientEvent {}

class SubmitPatientForm extends AddPatientEvent {
  final String fullName;
  final String dateOfBirth;
  final String email;
  final String address;
  final String phoneNumber;
  final String gender;
  final int registeredBy;

  SubmitPatientForm({
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.registeredBy,
  });
}
