import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/user_request.dart';

void main() {
  group('UserRequest', () {
    test('should create UserRequest with all fields', () {
      final request = UserRequest(
        email: 'user@example.com',
        name: 'Test User',
        location: 'Addis Ababa',
        phone: '1234567890',
        registedby: 42,
      );

      expect(request.email, 'user@example.com');
      expect(request.name, 'Test User');
      expect(request.location, 'Addis Ababa');
      expect(request.phone, '1234567890');
      expect(request.registedby, 42);
    });

    test('should allow null for optional fields', () {
      final request = UserRequest(
        email: 'user2@example.com',
      );

      expect(request.name, isNull);
      expect(request.location, isNull);
      expect(request.phone, isNull);
      expect(request.registedby, isNull);
      expect(request.email, 'user2@example.com');
    });
  });
}