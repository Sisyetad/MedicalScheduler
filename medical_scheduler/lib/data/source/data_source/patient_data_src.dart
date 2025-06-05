import 'package:medical_scheduler/domain/entities/response/patient.dart';

abstract class PatientDataSrc {
  Future<List<Patient>> getAllPatients();
  Future<Patient?> getPatientById(int id);
  Future<void> createPatient(Patient patient);
  Future<void> updatePatient(Patient patient);
  Future<void> deletePatient(int id);
}
