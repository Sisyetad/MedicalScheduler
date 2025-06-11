import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('HeadOffice', () {
    test('should create HeadOffice with correct values', () {
      final role = Role(roleId: 1, name: 'HeadOffice');
      final headoffice = HeadOffice(
        headofficeId: 1,
        username: 'headofficeuser',
        location: 'Addis Ababa',
        contactEmail: 'headoffice@example.com',
        contactPhone: '1234567890',
        password: 'pass',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        role: role,
      );

      expect(headoffice.headofficeId, 1);
      expect(headoffice.username, 'headofficeuser');
      expect(headoffice.location, 'Addis Ababa');
      expect(headoffice.email, 'headoffice@example.com');
      expect(headoffice.contactPhone, '1234567890');
      expect(headoffice.createdAt, '2024-01-01');
      expect(headoffice.updatedAt, '2024-01-02');
      expect(headoffice.role, role);
      expect(headoffice.userId, 1);
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 1, name: 'HeadOffice');
      final headoffice = HeadOffice(
        headofficeId: 1,
        username: 'headofficeuser',
        location: 'Addis Ababa',
        contactEmail: 'headoffice@example.com',
        contactPhone: '1234567890',
        password: 'pass',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        role: role,
      );

      final updated = headoffice.copyWith(
        username: 'newuser',
        email: 'new@example.com',
        password: 'newpass',
        updatedAt: '2024-02-01',
      );

      expect(updated.username, 'newuser');
      expect(updated.email, 'new@example.com');
      expect(updated.updatedAt, '2024-02-01');
      expect(updated.headofficeId, 1);
      expect(updated.role, role);
    });

    test('updateLocation should change location', () {
      final role = Role(roleId: 1, name: 'HeadOffice');
      final headoffice = HeadOffice(
        headofficeId: 1,
        username: 'headofficeuser',
        location: 'Addis Ababa',
        contactEmail: 'headoffice@example.com',
        contactPhone: '1234567890',
        password: 'pass',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        role: role,
      );

      headoffice.updateLocation('Bole');
      expect(headoffice.location, 'Bole');
    });

    test('updateContactPhone should change contactPhone', () {
      final role = Role(roleId: 1, name: 'HeadOffice');
      final headoffice = HeadOffice(
        headofficeId: 1,
        username: 'headofficeuser',
        location: 'Addis Ababa',
        contactEmail: 'headoffice@example.com',
        contactPhone: '1234567890',
        password: 'pass',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        role: role,
      );

      headoffice.updateContactPhone('0987654321');
      expect(headoffice.contactPhone, '0987654321');
    });
  });
}