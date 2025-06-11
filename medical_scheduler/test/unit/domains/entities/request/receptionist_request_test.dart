import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/receptionist_request.dart';

void main() {
  group('ReceptionistRequest', () {
    test('should create ReceptionistRequest with correct values', () {
      final emailStream = Stream<String>.empty();
      final request = ReceptionistRequest(
        email: emailStream,
        branchId: 3,
      );

      expect(request.email, emailStream);
      expect(request.branchId, 3);
    });
  });
}