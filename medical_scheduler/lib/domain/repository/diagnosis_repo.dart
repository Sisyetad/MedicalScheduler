// domain/repositories/diagnosis_repository.dart
import 'package:medical_scheduler/data/model/diagnosis_request_model.dart';

import '../entities/response/diagnosis_history.dart';

abstract class DiagnosisRepository {
  Future<List<DiagnosisHistory>> getAllDiagnoses();
  Future<DiagnosisHistory?> getDiagnosisById(int diagnosisId);
  Future<DiagnosisHistory> createDiagnosis(DiagnosisRequestModel diagnosis);
  Future<void> updateDiagnosis(DiagnosisHistory diagnosis);
  Future<bool> viewDiagnosis(int diagnosisId);
}
