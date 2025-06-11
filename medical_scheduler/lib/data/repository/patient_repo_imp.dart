// data/repositories/patient_repository_impl.dart
import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/patient_model.dart';
import 'package:medical_scheduler/data/source/data_source/patient_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/repository/patient_repo.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientDataSrc dataSource;

  PatientRepositoryImpl(this.dataSource);

  @override
  Future<List<Patient>> getAllPatients() async {
    return await dataSource.getAllPatients();
  }

  @override
  Future<Patient?> getPatientById(int id) async {
    return await dataSource.getPatientById(id);
  }

  @override
  Future<PatientModel> createPatient(PatientRequestModel patient) async {
    return await dataSource.createPatient(patient);
  }

  @override
  Future<void> updatePatient(Patient patient) async {
    await dataSource.updatePatient(patient);
  }

  @override
  Future<void> deletePatient(int id) async {
    await dataSource.deletePatient(id);
  }
}
