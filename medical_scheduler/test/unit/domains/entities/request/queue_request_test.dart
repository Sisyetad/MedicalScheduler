import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/queue_request.dart';

void main() {
  group('QueueRequest', () {
    test('should create QueueRequest with correct values', () {
      final request = QueueRequest(
        doctorId: 5,
        patientId: 12,
        status: 1,
      );

      expect(request.doctorId, 5);
      expect(request.patientId, 12);
      expect(request.status, 1);
    });
  });
}