abstract class AddPatientEvent {}

class SubmitPatientForm extends AddPatientEvent {
  final String fullName;
  final String dateOfBirth;
  final String email;
  final String address;
  final String phoneNumber;

  SubmitPatientForm({
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.address,
    required this.phoneNumber,
  });
} 