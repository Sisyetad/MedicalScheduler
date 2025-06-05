import 'package:medical_scheduler/data/model/diagnosis_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';

abstract class DiagnosisDataSrc {
  Future<List<DiagnosisHistory>> getAllDiagnoses();
  Future<DiagnosisHistory?> getDiagnosisByID(int diagnosisId);
  Future<DiagnosisHistory> createDiagnosis(DiagnosisRequestModel diagnosis);
  Future<bool> viewDiagnosis(int diagnosisId);
  Future<void> updateDiagnosis(DiagnosisHistory diagnosis);
}
