import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/patient_model.dart';
import 'package:medical_scheduler/data/source/data_source/patient_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';

class PatientDataSourceImpl implements PatientDataSrc {
  final Dio dio;

  PatientDataSourceImpl(this.dio);

  @override
  Future<List<PatientModel>> getAllPatients() async {
    try {
      final response = await dio.get('/patients');
      return (response.data as List)
          .map((e) => PatientModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load patients: $e');
    }
  }

  @override
  Future<PatientModel> getPatientById(int id) async {
    try {
      final response = await dio.get('/patients/$id');
      return PatientModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load patient with ID $id: $e');
    }
  }

  @override
  Future<void> createPatient(PatientRequestModel patient) async {
    try {
      await dio.post('/patients', data: patient.toJson());
    } catch (e) {
      throw Exception('Failed to create patient: $e');
    }
  }

  @override
  Future<void> updatePatient(Patient patient) async {
    try {
      await dio.put(
        '/patients/${patient.userId}',
        data: (patient as PatientModel).toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update patient with ID ${patient.userId}: $e');
    }
  }

  @override
  Future<void> deletePatient(int id) async {
    try {
      await dio.delete('/patients/$id');
    } catch (e) {
      throw Exception('Failed to delete patient with ID $id: $e');
    }
  }
}
