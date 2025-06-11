import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/queue_request.dart';

void main() {
  group('QueueRequest', () {
    test('should create QueueRequest with correct values', () {
      final request = QueueRequest(patientId: 12);

      expect(request.patientId, 12);
    });
  });
}
