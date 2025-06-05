// domain/usecases/patient/get_all_patients.dart
import '../../entities/response/patient.dart';
import '../../repository/patient_repo.dart';

class GetpatientById {
  final PatientRepository repository;

  GetpatientById(this.repository);

  Future<Patient?> call(int patientId) => repository.getPatientById(patientId);
}
