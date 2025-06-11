import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/request/signup_request.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

void main() {
  group('SignupRequest', () {
    test('should create SignupRequest with correct values', () {
      final role = Role(roleId: 1, name: 'Doctor');
      final request = SignupRequest(
        email: 'user@example.com',
        name: 'User Name',
        password: 'password123',
        location: 'Addis Ababa',
        speciality: 'Cardiology',
        role: role,
      );

      expect(request.email, 'user@example.com');
      expect(request.name, 'User Name');
      expect(request.password, 'password123');
      expect(request.location, 'Addis Ababa');
      expect(request.speciality, 'Cardiology');
      expect(request.role, role);
    });

    test('should allow null for optional fields', () {
      final role = Role(roleId: 2, name: 'Receptionist');
      final request = SignupRequest(
        email: 'recept@example.com',
        name: 'Receptionist',
        password: 'pass456',
        role: role,
      );

      expect(request.location, isNull);
      expect(request.speciality, isNull);
    });
  });

  group('SignupBody', () {
    test('should create SignupBody with correct values', () {
      final role = Role(roleId: 3, name: 'Admin');
      final body = SignupBody(
        name: 'Admin User',
        password: 'adminpass',
        location: 'HQ',
        speciality: 'Management',
        role: role,
      );

      expect(body.name, 'Admin User');
      expect(body.password, 'adminpass');
      expect(body.location, 'HQ');
      expect(body.speciality, 'Management');
      expect(body.role, role);
    });

    test('should allow null for optional fields', () {
      final body = SignupBody(
        name: 'Simple User',
        password: 'simplepass',
      );

      expect(body.location, isNull);
      expect(body.speciality, isNull);
      expect(body.role, isNull);
    });
  });
}