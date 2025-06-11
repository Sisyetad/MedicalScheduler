import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('DataQueue', () {
    test('should create DataQueue with correct values', () {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );
      final patient = Patient(
        patientId: 2,
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
      final queue = DataQueue(
        status: 1,
        patient: patient,
        doctor: doctor,
        queueId: 100,
        createdAt: '2024-06-01',
        updatedAt: '2024-06-02',
      );

      expect(queue.status, 1);
      expect(queue.patient, patient);
      expect(queue.doctor, doctor);
      expect(queue.queueId, 100);
      expect(queue.createdAt, '2024-06-01');
      expect(queue.updatedAt, '2024-06-02');
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );
      final patient = Patient(
        patientId: 2,
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
      final queue = DataQueue(
        status: 1,
        patient: patient,
        doctor: doctor,
        queueId: 100,
        createdAt: '2024-06-01',
        updatedAt: '2024-06-02',
      );

      final updated = queue.copyWith(
        status: 2,
        updatedAt: '2024-06-03',
      );

      expect(updated.status, 2);
      expect(updated.updatedAt, '2024-06-03');
      expect(updated.patient, patient);
      expect(updated.doctor, doctor);
      expect(updated.queueId, 100);
      expect(updated.createdAt, '2024-06-01');
    });
  });
}