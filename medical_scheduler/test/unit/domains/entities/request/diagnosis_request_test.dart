// medical_scheduler/lib/domain/entities/request/diagnosis_request_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/diagnosis_request.dart';

void main() {
  group('DiagnosisRequest', () {
    test('should create DiagnosisRequest with correct values', () {
      // Arrange
      final diagnosisRequest = DiagnosisRequest(
        comment: 'Patient has mild symptoms',
        diagnosisName: 'Flu',
        doctorId: 1,
        medication: 'Rest and fluids',
        patientId: 2,
        visible: true,
      );

      // Assert
      expect(diagnosisRequest.comment, 'Patient has mild symptoms');
      expect(diagnosisRequest.diagnosisName, 'Flu');
      expect(diagnosisRequest.doctorId, 1);
      expect(diagnosisRequest.medication, 'Rest and fluids');
      expect(diagnosisRequest.patientId, 2);
      expect(diagnosisRequest.visible, isTrue);
    });
  });
}