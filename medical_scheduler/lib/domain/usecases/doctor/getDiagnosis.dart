// domain/usecases/diagnosis/get_diagnosis_by_id.dart
import '../../entities/response/diagnosis_history.dart';
import '../../repository/diagnosis_repo.dart';

class GetDiagnosisById {
  final DiagnosisRepository repository;

  GetDiagnosisById(this.repository);

  Future<DiagnosisHistory?> call(int diagnosisId) => repository.getDiagnosisById(diagnosisId);
}
