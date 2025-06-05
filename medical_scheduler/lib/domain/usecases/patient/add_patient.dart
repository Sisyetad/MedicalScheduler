// domain/usecases/patient/create_patient.dart
import '../../entities/response/patient.dart';
import '../../repository/patient_repo.dart';

class CreatePatient {
  final PatientRepository repository;

  CreatePatient(this.repository);

  Future<void> call(Patient patient) => repository.createPatient(patient);
}
