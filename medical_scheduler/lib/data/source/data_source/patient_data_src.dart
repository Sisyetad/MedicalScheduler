import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';

abstract class PatientDataSrc {
  Future<List<Patient>> getAllPatients();
  Future<Patient?> getPatientById(int id);
  Future<void> createPatient(PatientRequestModel patient);
  Future<void> updatePatient(Patient patient);
  Future<void> deletePatient(int id);
}
