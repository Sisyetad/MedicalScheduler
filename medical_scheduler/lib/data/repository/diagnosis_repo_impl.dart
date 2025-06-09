// data/repositories/diagnosis_repository_impl.dart
import 'package:medical_scheduler/data/model/RequestModel/diagnosis_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/data/source/data_source/diagnosis_data_src.dart';
import 'package:medical_scheduler/domain/repository/diagnosis_repo.dart';

class DiagnosisRepositoryImpl implements DiagnosisRepository {
  final DiagnosisDataSrc dataSource;

  DiagnosisRepositoryImpl(this.dataSource);

  @override
  Future<List<DiagnosisHistory>> getAllDiagnoses() async {
    return await dataSource.getAllDiagnoses();
  }

  @override
  Future<DiagnosisHistory?> getDiagnosisById(int diagnosisId) async {
    return await dataSource.getDiagnosisByID(diagnosisId);
  }

  @override
  Future<DiagnosisHistory> createDiagnosis(
    DiagnosisRequestModel diagnosis,
  ) async {
    return await dataSource.createDiagnosis(diagnosis);
  }

  @override
  Future<void> updateDiagnosis(DiagnosisHistory diagnosis) async {
    await dataSource.updateDiagnosis(diagnosis);
  }

  @override
  Future<bool> viewDiagnosis(int diagnosisId) async {
    return await dataSource.viewDiagnosis(diagnosisId);
  }
}
