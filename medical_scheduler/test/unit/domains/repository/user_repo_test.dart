import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/domain/repository/user_repo.dart';
import 'package:medical_scheduler/data/model/RequestModel/register_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/user_model.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

// Mock class for UserRepo
class MockUserRepo extends Mock implements UserRepo {}

void main() {
  late MockUserRepo mockRepo;

  setUp(() {
    mockRepo = MockUserRepo();
  });

  group('UserRepo', () {
    test('getAllUsers returns list of User', () async {
      final role = Role(roleId: 1, name: 'User');
      final user = User(
        userId: 1,
        username: 'testuser',
        email: 'test@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );

      when(mockRepo.getAllUsers()).thenAnswer((_) async => [user]);

      final result = await mockRepo.getAllUsers();

      expect(result, isA<List<User>>());
      expect(result.length, 1);
      expect(result.first.userId, 1);
    });

    test('updateUser returns updated UserModel', () async {
      final updatedUser = UserModel(
        userId: 1,
        username: 'updateduser',
        email: 'updated@example.com',
        password: 'newpass',
        role: Role(roleId: 1, name: 'User'),
        createdAt: '2024-01-01',
        updatedAt: '2024-02-01',
      );
      final requestModel = RegisterRequestModel(
        name: 'updateduser',
        email: 'updated@example.com',
        password: 'newpass',
        role: Role(roleId: 1, name: 'User'),
      );

      when(mockRepo.updateUser(1, requestModel)).thenAnswer((_) async => updatedUser);

      final result = await mockRepo.updateUser(1, requestModel);

      expect(result, isA<UserModel>());
      expect(result.username, 'updateduser');
      expect(result.email, 'updated@example.com');
    });

    test('deleteUser returns confirmation string', () async {
      when(mockRepo.deleteUser(1)).thenAnswer((_) async => 'User deleted');

      final result = await mockRepo.deleteUser(1);

      expect(result, 'User deleted');
      verify(mockRepo.deleteUser(1)).called(1);
    });
  });
}