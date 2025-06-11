import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';

void main() {
  group('Doctor', () {
    test('should create Doctor with correct values', () {
      final role = Role(roleId: 1, name: 'Doctor');
      final branch = Branch(
        branchId: 10,
        username: 'branchuser',
        email: 'branch@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        contactPhone: '1234567890',
        specialization: 'General',
        isSignedUp: true,
        headOffice: null,
        location: 'Bole',
      );
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        specialization: 'Cardiology',
        branch: branch,
        isSignedUp: true,
      );

      expect(doctor.doctorId, 1);
      expect(doctor.username, 'Dr. Smith');
      expect(doctor.email, 'drsmith@example.com');
      expect(doctor.role, role);
      expect(doctor.createdAt, '2024-01-01');
      expect(doctor.updatedAt, '2024-01-02');
      expect(doctor.specialization, 'Cardiology');
      expect(doctor.branch, branch);
      expect(doctor.isSignedUp, true);
      expect(doctor.userId, 1);
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 1, name: 'Doctor');
      final branch = Branch(
        branchId: 10,
        username: 'branchuser',
        email: 'branch@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        contactPhone: '1234567890',
        specialization: 'General',
        isSignedUp: true,
        headOffice: null,
        location: 'Bole',
      );
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        specialization: 'Cardiology',
        branch: branch,
        isSignedUp: true,
      );

      final updated = doctor.copyWith(
        username: 'Dr. John',
        email: 'drjohn@example.com',
        specialization: 'Neurology',
        isSignedUp: false,
      );

      expect(updated.username, 'Dr. John');
      expect(updated.email, 'drjohn@example.com');
      expect(updated.specialization, 'Neurology');
      expect(updated.isSignedUp, false);
      expect(updated.doctorId, 1);
      expect(updated.role, role);
    });
  });
}