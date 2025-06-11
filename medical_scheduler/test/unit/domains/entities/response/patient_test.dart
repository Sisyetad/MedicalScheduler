import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('Patient', () {
    test('should create Patient with correct values', () {
      final role = Role(roleId: 2, name: 'Patient');
      final patient = Patient(
        patientId: 1,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        phoneNumber: '1234567890',
        gender: 'Male',
        dateOfBirth: '1990-01-01',
        registeredBy: null,
      );

      expect(patient.patientId, 1);
      expect(patient.username, 'john_doe');
      expect(patient.email, 'john@example.com');
      expect(patient.role, role);
      expect(patient.createdAt, '2024-01-01');
      expect(patient.updatedAt, '2024-01-02');
      expect(patient.firstName, 'John');
      expect(patient.lastName, 'Doe');
      expect(patient.address, '123 Main St');
      expect(patient.phoneNumber, '1234567890');
      expect(patient.gender, 'Male');
      expect(patient.dateOfBirth, '1990-01-01');
      expect(patient.registeredBy, null);
      expect(patient.userId, 1);
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 2, name: 'Patient');
      final patient = Patient(
        patientId: 1,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        phoneNumber: '1234567890',
        gender: 'Male',
        dateOfBirth: '1990-01-01',
        registeredBy: null,
      );

      final updated = patient.copyWith(
        username: 'jane_doe',
        email: 'jane@example.com',
        password: 'newpass',
        newPhone: '0987654321',
        newAddress: '456 Elm St',
        gender: 'Female',
        dateOfBirth: '1992-02-02',
        firstName: 'Jane',
        lastName: 'Smith',
      );

      expect(updated.username, 'jane_doe');
      expect(updated.email, 'jane@example.com');
      expect(updated.phoneNumber, '0987654321');
      expect(updated.address, '456 Elm St');
      expect(updated.gender, 'Female');
      expect(updated.dateOfBirth, '1992-02-02');
      expect(updated.firstName, 'Jane');
      expect(updated.lastName, 'Smith');
      expect(updated.role, role);
      expect(updated.patientId, 1);
    });
  });
}