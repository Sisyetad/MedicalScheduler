import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/domain/repository/diagnosis_repo.dart';

class CreateDiagnosis extends UseCase<DiagnosisHistory, CreateDiagnosisParams> {
  final DiagnosisRepository repository;

  CreateDiagnosis(this.repository);

  @override
  Future<DiagnosisHistory> call(CreateDiagnosisParams params) {
    return repository.createDiagnosis(params.diagnosisRequest);
  }
}
