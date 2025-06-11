import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/data/repository/auth_repo_imp.dart';
import 'package:medical_scheduler/domain/entities/response/authresponse.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/data/source/data_source/authDataSrc.dart';

// Create a Mock for AuthDataSource using mockito
class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepositoryImpl', () {
    test('login should call dataSource.login and return AuthResponse', () async {
      final authResponse = AuthResponse(token: 'abc123');
      when(mockDataSource.login('test@example.com', 'password'))
          .thenAnswer((_) async => authResponse);

      final result = await repository.login('test@example.com', 'password');

      expect(result, authResponse);
      verify(mockDataSource.login('test@example.com', 'password')).called(1);
    });

    test('register should call dataSource.register and return AuthResponse', () async {
      final authResponse = AuthResponse(token: 'xyz456');
      final role = Role(roleId: 1, name: 'User');
      when(mockDataSource.register('Test', 'test@example.com', 'password', role))
          .thenAnswer((_) async => authResponse);

      final result = await repository.register('Test', 'test@example.com', 'password', role);

      expect(result, authResponse);
      verify(mockDataSource.register('Test', 'test@example.com', 'password', role)).called(1);
    });

    test('getUserProfile should call dataSource.getUserProfile and return User', () async {
      final user = User(
        userId: 1,
        username: 'testuser',
        email: 'test@example.com',
        password: 'hashedpassword',
        role: Role(roleId: 1, name: 'User'),
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );

      final result = await repository.getUserProfile('token123');

      expect(result.userId, user.userId);
      expect(result.username, user.username);
      expect(result.email, user.email);
      expect(result.passwordHash, user.passwordHash);
      expect(result.role, user.role);
      expect(result.createdAt, user.createdAt);
      expect(result.updatedAt, user.updatedAt);
      verify(mockDataSource.getUserProfile('token123')).called(1);
    });
  });
}