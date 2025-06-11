// domain/usecases/patient/create_patient.dart
import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import '../../../domain/repository/patient_repo.dart';

class CreatePatient {
  final PatientRepository repository;

  CreatePatient(this.repository);

  Future<Patient> call(PatientRequestModel patient) =>
      repository.createPatient(patient);
}
