import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';

abstract class DiagnosisFormEvents {}

class UpdateDiagnosis extends DiagnosisFormEvents {
  final DiagnosisHistory diagnosisHistory;
  UpdateDiagnosis(this.diagnosisHistory);
}

class SubmitForm extends DiagnosisFormEvents{
  
}

