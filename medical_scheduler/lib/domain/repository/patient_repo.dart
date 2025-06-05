import 'package:medical_scheduler/domain/entities/response/patient.dart';

abstract class PatientRepository {
  Future<List<Patient>> getAllPatients();
  Future<Patient?> getPatientById(int patientId);
  Future<void> createPatient(Patient patient);
  Future<void> updatePatient(Patient patient);
  Future<void> deletePatient(int id);
}
