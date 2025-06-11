import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('Branch', () {
    test('should create Branch with correct values', () {
      final role = Role(roleId: 2, name: 'Branch');
      final headOffice = HeadOffice(
        headofficeId: 1,
        username: 'headofficeuser',
        location: 'Addis Ababa',
        contactEmail: 'headoffice@example.com',
        contactPhone: '1234567890',
        password: 'headofficepass',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        role: role,
      );
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
        headOffice: headOffice,
        location: 'Bole',
      );

      expect(branch.branchId, 10);
      expect(branch.username, 'branchuser');
      expect(branch.email, 'branch@example.com');
      expect(branch.role, role);
      expect(branch.createdAt, '2024-01-01');
      expect(branch.updatedAt, '2024-01-02');
      expect(branch.contactPhone, '1234567890');
      expect(branch.specialization, 'General');
      expect(branch.isSignedUp, true);
      expect(branch.headOffice, headOffice);
      expect(branch.location, 'Bole');
      expect(branch.userId, 10);
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 2, name: 'Branch');
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

      final updated = branch.copyWith(
        username: 'newuser',
        email: 'new@example.com',
        updatedAt: '2024-02-01',
        location: 'Kazanchis',
        contactPhone: '0987654321',
        specialization: 'Pediatrics',
        isSignedUp: false,
      );

      expect(updated.username, 'newuser');
      expect(updated.email, 'new@example.com');
      expect(updated.updatedAt, '2024-02-01');
      expect(updated.location, 'Kazanchis');
      expect(updated.contactPhone, '0987654321');
      expect(updated.specialization, 'Pediatrics');
      expect(updated.isSignedUp, false);
      expect(updated.branchId, 10);
      expect(updated.role, role);
    });
  });
}