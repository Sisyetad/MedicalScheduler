import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Auth/auth_view_model.dart';
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart';
import 'package:medical_scheduler/Application/Usecases/auth/login.dart';
import 'package:medical_scheduler/Application/Usecases/auth/signUp.dart';
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/authresponse.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockGetUserUseCase extends Mock implements GetUserUseCase {}
class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockGetUserUseCase mockGetUserUseCase;
  late MockStorage mockStorage;
  late AuthViewModel viewModel;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockGetUserUseCase = MockGetUserUseCase();
    mockStorage = MockStorage();
    viewModel = AuthViewModel(mockLoginUseCase, mockGetUserUseCase, mockRegisterUseCase);
  });

  test('onEvent(UpdateEmail) updates email in state', () {
    viewModel.onEvent(UpdateEmail('test@example.com'));
    expect(viewModel.state.email, 'test@example.com');
    expect(viewModel.state.error, null);
  });

  test('onEvent(UpdatePassword) updates password in state', () {
    viewModel.onEvent(UpdatePassword('secret'));
    expect(viewModel.state.password, 'secret');
    expect(viewModel.state.error, null);
  });

  test('onEvent(UpdateName) updates name in state', () {
    viewModel.onEvent(UpdateName('Alice'));
    expect(viewModel.state.name, 'Alice');
    expect(viewModel.state.error, null);
  });

  test('onEvent(Logout) resets state', () async {
    viewModel.state = viewModel.state.copyWith(email: 'test@example.com');
    expect(viewModel.state.email, null);
    verify(mockStorage.delete(key: 'auth_token')).called(1);
  });

  test('onEvent(SubmitLogin) logs in and updates state', () async {
    final user = User(
      userId: 1,
      username: 'testuser',
      email: 'test@example.com',
      password: 'pass',
      role: Role(roleId: 1, name: 'User'),
      createdAt: '2024-01-01',
      updatedAt: '2024-01-02',
    );
    final authResponse = AuthResponse(token: 'abc123');
    when(mockGetUserUseCase.call('abc123')).thenAnswer((_) async => user);


    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.isSuccess, true);
    expect(viewModel.state.user, user);
    expect(viewModel.state.error, null);
    verify(mockStorage.write(key: 'auth_token', value: 'abc123')).called(1);
  });

  test('onEvent(SubmitSignup) registers and updates state', () async {
    final user = User(
      userId: 2,
      username: 'newuser',
      email: 'new@example.com',
      password: 'pass',
      role: Role(roleId: 4, name: 'Doctor'),
      createdAt: '2024-01-01',
      updatedAt: '2024-01-02',
    );
    final authResponse = AuthResponse(token: 'signup123');
    when(mockGetUserUseCase.call('signup123')).thenAnswer((_) async => user);



    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.isSuccess, true);
    expect(viewModel.state.user, user);
    expect(viewModel.state.error, null);
    verify(mockStorage.write(key: 'auth_token', value: 'signup123')).called(1);
  });

  test('onEvent(SubmitLogin) sets error on exception', () async {
    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.error, contains('Exception'));
  });

  test('onEvent(SubmitSignup) sets error on exception', () async {
    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.error, contains('Exception'));
  });

  test('checkLoginStatus loads user if token exists', () async {
    final user = User(
      userId: 3,
      username: 'persisted',
      email: 'persisted@example.com',
      password: 'pass',
      role: Role(roleId: 1, name: 'User'),
      createdAt: '2024-01-01',
      updatedAt: '2024-01-02',
    );
    when(mockGetUserUseCase.call('token123')).thenAnswer((_) async => user);

    await viewModel.checkLoginStatus();

    expect(viewModel.state.user, user);
    expect(viewModel.state.isLoading, false);
  });

  test('checkLoginStatus sets user to null if no token', () async {

    await viewModel.checkLoginStatus();

    expect(viewModel.state.user, null);
    expect(viewModel.state.isLoading, false);
  });

  test('checkLoginStatus sets error on exception', () async {

    await viewModel.checkLoginStatus();

    expect(viewModel.state.user, null);
    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.error, contains('Exception'));
  });
}