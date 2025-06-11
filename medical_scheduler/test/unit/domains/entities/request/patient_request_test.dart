import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/patient_request.dart';

void main() {
  group('PatientRequest', () {
    test('should create PatientRequest with correct values', () {
      final request = PatientRequest(
        firstName: 'John',
        lastName: 'Doe',
        gender: 'Male',
        dateofBirth: '1990-01-01',
        address: '123 Main St',
        email: 'john.doe@example.com',
        phone: '1234567890',
        registeredby: 1,
      );

      expect(request.firstName, 'John');
      expect(request.lastName, 'Doe');
      expect(request.gender, 'Male');
      expect(request.dateofBirth, '1990-01-01');
      expect(request.address, '123 Main St');
      expect(request.email, 'john.doe@example.com');
      expect(request.phone, '1234567890');
      expect(request.registeredby, 1);
    });

    test('should allow null for optional fields', () {
      final request = PatientRequest(
        firstName: 'Jane',
        lastName: 'Smith',
        gender: 'Female',
        dateofBirth: '1985-05-05',
        phone: '0987654321',
        registeredby: 2,
      );

      expect(request.address, isNull);
      expect(request.email, isNull);
    });
  });
}