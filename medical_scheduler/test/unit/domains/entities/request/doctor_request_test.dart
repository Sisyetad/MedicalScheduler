import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';

void main() {
  group('EmployeeRequest', () {
    test('should create EmployeeRequest with correct values', () {
      final request = EmployeeRequest(
        username: 'doctor1',
        email: 'doctor1@example.com',
        branchId: 10,
      );

      expect(request.username, 'doctor1');
      expect(request.email, 'doctor1@example.com');
      expect(request.branchId, 10);
    });

    test('copyWith should update fields correctly', () {
      final request = EmployeeRequest(
        username: 'doctor1',
        email: 'doctor1@example.com',
        branchId: 10,
      );

      final updated = request.copyWith(
        username: 'doctor2',
        email: 'doctor2@example.com',
        branchId: 20,
      );

      expect(updated.username, 'doctor2');
      expect(updated.email, 'doctor2@example.com');
      expect(updated.branchId, 20);
    });

    test('copyWith should keep original values if not provided', () {
      final request = EmployeeRequest(
        username: 'doctor1',
        email: 'doctor1@example.com',
        branchId: 10,
      );

      final updated = request.copyWith();

      expect(updated.username, 'doctor1');
      expect(updated.email, 'doctor1@example.com');
      expect(updated.branchId, 10);
    });
  });
}