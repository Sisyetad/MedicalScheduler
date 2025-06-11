import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Admin/admin_dashboard_view_model.dart';
import 'package:medical_scheduler/Application/Usecases/admin/get_admin_dashboard_data.dart';
import 'package:medical_scheduler/Application/Usecases/user/delete_user.dart';
import 'package:medical_scheduler/presentation/events/Admin/admin_dashboard_events.dart';
import 'package:medical_scheduler/presentation/Provider/states/Admin/admin_dashboard_state.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

// Mocks
class MockGetAdminDashboardData extends Mock implements GetAdminDashboardData {}
class MockDeleteUser extends Mock implements DeleteUser {}

void main() {
  late MockGetAdminDashboardData mockGetAdminDashboardData;
  late MockDeleteUser mockDeleteUser;
  late AdminDashboardNotifier notifier;

  setUp(() {
    mockGetAdminDashboardData = MockGetAdminDashboardData();
    mockDeleteUser = MockDeleteUser();
    notifier = AdminDashboardNotifier(mockGetAdminDashboardData, mockDeleteUser);
  });

  test('initial state is correct', () {
    expect(notifier.state, isA<AdminDashboardState>());
    expect(notifier.state.isLoading, false);
    expect(notifier.state.error, null);
  });

  test('onEvent(FetchDashboardData) updates state with dashboard data', () async {
    final role = Role(roleId: 1, name: 'User');
    final users = [
      User(
        userId: 1,
        username: 'testuser',
        email: 'test@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      ),
    ];


    await notifier.onEvent(FetchDashboardData());

    expect(notifier.state.isLoading, false);
    expect(notifier.state.doctorCount, 2);
    expect(notifier.state.receptionistCount, 3);
    expect(notifier.state.allEmployees, users);
    expect(notifier.state.displayedEmployees, users);
    expect(notifier.state.error, null);
  });

  test('onEvent(SearchEmployees) filters employees', () async {
    final role = Role(roleId: 1, name: 'User');
    final users = [
      User(
        userId: 1,
        username: 'alice',
        email: 'alice@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      ),
      User(
        userId: 2,
        username: 'bob',
        email: 'bob@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      ),
    ];
    notifier.state = notifier.state.copyWith(
      allEmployees: users,
      displayedEmployees: users,
    );

    await notifier.onEvent(SearchEmployees('bob'));

    expect(notifier.state.displayedEmployees.length, 1);
    expect(notifier.state.displayedEmployees.first.username, 'bob');
  });

  test('onEvent(DeleteEmployee) calls delete and refreshes data', () async {

    await notifier.onEvent(DeleteEmployee(1));

    verify(mockDeleteUser.call(1)).called(1);
    verify(mockGetAdminDashboardData.call()).called(1);
  });

  test('onEvent(FetchDashboardData) sets error on exception', () async {
    when(mockGetAdminDashboardData.call()).thenThrow(Exception('error'));

    await notifier.onEvent(FetchDashboardData());

    expect(notifier.state.isLoading, false);
    expect(notifier.state.error, contains('Exception'));
  });
}