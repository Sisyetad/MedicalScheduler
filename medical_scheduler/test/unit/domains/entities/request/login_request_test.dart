import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/login_request.dart';

void main() {
  group('LoginRequest', () {
    test('should create LoginRequest with correct values', () {
      final request = LoginRequest(
        email: 'user@example.com',
        password: 'securePassword123',
      );

      expect(request.email, 'user@example.com');
      expect(request.password, 'securePassword123');
    });
  });
}