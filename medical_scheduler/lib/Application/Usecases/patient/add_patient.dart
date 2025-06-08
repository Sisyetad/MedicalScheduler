// domain/usecases/patient/create_patient.dart
import '../../../domain/entities/response/patient.dart';
import '../../../domain/repository/patient_repo.dart';

class CreatePatient {
  final PatientRepository repository;

  CreatePatient(this.repository);

  Future<void> call(Patient patient) => repository.createPatient(patient);
}
