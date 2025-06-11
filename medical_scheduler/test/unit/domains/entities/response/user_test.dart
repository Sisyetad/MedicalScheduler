import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('User', () {
    test('should create User with correct values', () {
      final role = Role(roleId: 1, name: 'Admin');
      final user = User(
        userId: 1,
        username: 'testuser',
        email: 'test@example.com',
        password: 'hashedpassword',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );

      expect(user.userId, 1);
      expect(user.username, 'testuser');
      expect(user.email, 'test@example.com');
      expect(user.passwordHash, 'hashedpassword');
      expect(user.role, role);
      expect(user.createdAt, '2024-01-01');
      expect(user.updatedAt, '2024-01-02');
    });

    test('copyWith should update fields correctly', () {
      final role = Role(roleId: 1, name: 'Admin');
      final user = User(
        userId: 1,
        username: 'testuser',
        email: 'test@example.com',
        password: 'hashedpassword',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );

      final updated = user.copyWith(
        username: 'newuser',
        email: 'new@example.com',
        password: 'newhashedpassword',
        updatedAt: '2024-02-01',
      );

      expect(updated.username, 'newuser');
      expect(updated.email, 'new@example.com');
      expect(updated.passwordHash, 'newhashedpassword');
      expect(updated.updatedAt, '2024-02-01');
      expect(updated.userId, 1);
      expect(updated.role, role);
    });
  });
}