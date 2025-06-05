import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/model/diagnosis_history_model.dart';
import 'package:medical_scheduler/data/model/diagnosis_request_model.dart';
import 'package:medical_scheduler/data/source/data_source/diagnosis_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';

class DiagnosisDataSrcImpl implements DiagnosisDataSrc {
  final Dio dio;

  DiagnosisDataSrcImpl({required this.dio});

  @override
  Future<List<DiagnosisHistory>> getAllDiagnoses() async {
    try {
      final response = await dio.get('/diagnoses');
      return (response.data as List)
          .map((json) => DiagnosisHistoryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load diagnoses: $e');
    }
  }

  @override
  Future<DiagnosisHistory?> getDiagnosisByID(int diagnosisId) async {
    try {
      final response = await dio.get('/diagnoses/$diagnosisId');
      return DiagnosisHistoryModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load diagnosis with ID $diagnosisId: $e');
    }
  }

  @override
  Future<DiagnosisHistory> createDiagnosis(DiagnosisRequestModel diagnosis) async {
    try {
      final response = await dio.post(
        '/diagnoses',
        data: diagnosis.toJson(),
      );
      return DiagnosisHistoryModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create diagnosis: $e');
    }
  }

  @override
  Future<bool> viewDiagnosis(int diagnosisId) async {
    try {
      final response = await dio.patch('/diagnoses/view/$diagnosisId');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to mark diagnosis as viewed: $e');
    }
  }

  @override
  Future<void> updateDiagnosis(DiagnosisHistory diagnosis) async {
    try {
      final updatedModel = diagnosis as DiagnosisHistoryModel;

      await dio.put(
        '/diagnoses/${diagnosis.diagnosisId}',
        data: updatedModel.toJson(),
      );
    } catch (e) {
      throw Exception(
        'Failed to update diagnosis with ID ${diagnosis.diagnosisId}: $e',
      );
    }
  }
}
