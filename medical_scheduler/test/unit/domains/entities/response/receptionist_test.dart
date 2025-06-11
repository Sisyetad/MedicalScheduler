import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';

void main() {
  group('Receptionist', () {
    test('should create Receptionist with correct values', () {
      final role = Role(roleId: 3, name: 'Receptionist');
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
      final receptionist = Receptionist(
        receptionistId: 1,
        username: 'recept1',
        email: 'recept1@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        branch: branch,
        isSignedUp: true,
      );

      expect(receptionist.receptionistId, 1);
      expect(receptionist.username, 'recept1');
      expect(receptionist.email, 'recept1@example.com');
      expect(receptionist.role, role);
      expect(receptionist.createdAt, '2024-01-01');
      expect(receptionist.updatedAt, '2024-01-02');
      expect(receptionist.branch, branch);
      expect(receptionist.isSignedUp, true);
      expect(receptionist.userId, 1);
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 3, name: 'Receptionist');
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
      final receptionist = Receptionist(
        receptionistId: 1,
        username: 'recept1',
        email: 'recept1@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        branch: branch,
        isSignedUp: true,
      );

      final updated = receptionist.copyWith(
        username: 'recept2',
        email: 'recept2@example.com',
        password: 'newpass',
        updatedAt: '2024-02-01',
        isSignedUp: false,
      );

      expect(updated.username, 'recept2');
      expect(updated.email, 'recept2@example.com');
      expect(updated.updatedAt, '2024-02-01');
      expect(updated.isSignedUp, false);
      expect(updated.branch, branch);
      expect(updated.role, role);
      expect(updated.receptionistId, 1);
    });
  });
}