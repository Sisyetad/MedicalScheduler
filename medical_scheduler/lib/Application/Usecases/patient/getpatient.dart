// domain/usecases/patient/get_all_patients.dart
import '../../../domain/entities/response/patient.dart';
import '../../../domain/repository/patient_repo.dart';

class GetpatientById {
  final PatientRepository repository;

  GetpatientById(this.repository);

  Future<Patient?> call(int patientId) => repository.getPatientById(patientId);
}
