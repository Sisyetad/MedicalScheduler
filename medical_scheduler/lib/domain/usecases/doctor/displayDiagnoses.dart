// domain/usecases/diagnosis/get_all_diagnoses.dart
import '../../entities/response/diagnosis_history.dart';
import '../../repository/diagnosis_repo.dart';

class GetAllDiagnoses {
  final DiagnosisRepository repository;

  GetAllDiagnoses(this.repository);

  Future<List<DiagnosisHistory>> call() => repository.getAllDiagnoses();
}
