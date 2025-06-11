import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/authresponse.dart';

void main() {
  group('AuthResponse', () {
    test('should create AuthResponse with correct token', () {
      final response = AuthResponse(token: 'abc123token');

      expect(response.token, 'abc123token');
    });
  });
}