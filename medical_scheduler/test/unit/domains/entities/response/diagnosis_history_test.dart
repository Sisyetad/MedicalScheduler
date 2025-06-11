import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('DiagnosisHistory', () {
    test('should create DiagnosisHistory with correct values', () {
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
      final history = DiagnosisHistory(
        diagnosisId: 100,
        diagnosisName: 'Flu',
        doctor: doctor,
        medication: 'Rest',
        createdTime: '2024-06-01',
        comment: 'Mild symptoms',
        patient: patient,
        updatedAt: '2024-06-02',
        visible: true,
      );

      expect(history.diagnosisId, 100);
      expect(history.diagnosisName, 'Flu');
      expect(history.doctor, doctor);
      expect(history.medication, 'Rest');
      expect(history.createdTime, '2024-06-01');
      expect(history.comment, 'Mild symptoms');
      expect(history.patient, patient);
      expect(history.updatedAt, '2024-06-02');
      expect(history.visible, true);
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
      final history = DiagnosisHistory(
        diagnosisId: 100,
        diagnosisName: 'Flu',
        doctor: doctor,
        medication: 'Rest',
        createdTime: '2024-06-01',
        comment: 'Mild symptoms',
        patient: patient,
        updatedAt: '2024-06-02',
        visible: false,
      );

      final updated = history.copyWith(
        medication: 'and fluids',
        comment: 'Getting better',
        visible: true,
        updatedAt: '2024-06-03',
      );

      expect(updated.medication, 'Rest and fluids');
      expect(updated.comment, 'Mild symptoms Getting better');
      expect(updated.visible, true);
      expect(updated.updatedAt, '2024-06-03');
    });
  });
}