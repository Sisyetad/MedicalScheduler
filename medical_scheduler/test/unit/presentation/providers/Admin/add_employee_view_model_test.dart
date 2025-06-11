import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Admin/add_employee_view_model.dart';
import 'package:medical_scheduler/Application/Usecases/doctor/add_doctor.dart';
import 'package:medical_scheduler/Application/Usecases/receptionist/add_receptionist.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/presentation/Provider/states/Admin/add_employee_state.dart';
import 'package:medical_scheduler/presentation/events/Admin/add_employee_events.dart';

// Mocks
class MockAddDoctor extends Mock implements AddDoctor {}
class MockAddReceptionist extends Mock implements AddReceptionist {}

void main() {
  late MockAddDoctor mockAddDoctor;
  late MockAddReceptionist mockAddReceptionist;
  late AddEmployeeNotifier notifier;

  setUp(() {
    mockAddDoctor = MockAddDoctor();
    mockAddReceptionist = MockAddReceptionist();
    notifier = AddEmployeeNotifier(
      addDoctorUseCase: mockAddDoctor,
      addReceptionistUseCase: mockAddReceptionist,
    );
  });

  test('initial state is correct', () {
    expect(notifier.state, isA<AddEmployeeState>());
    expect(notifier.state.isLoading, false);
    expect(notifier.state.isSuccess, false);
    expect(notifier.state.error, null);
    expect(notifier.state.selectedRole, null);
  });

  test('onEvent(EmployeeRoleSelected) updates selectedRole', () {
    notifier.onEvent(EmployeeRoleSelected('Doctor'));
    expect(notifier.state.selectedRole, 'Doctor');
  });

  test('onEvent(UpdateEmployeeName) updates employeeRequest username', () {
    notifier.state = notifier.state.copyWith(
      employeeRequest: EmployeeRequestModel(
        username: null,
        email: 'test@example.com',
        branchId: 1,
      ),
    );
    notifier.onEvent(UpdateEmployeeName('Alice'));
    expect(notifier.state.employeeRequest?.username, 'Alice');
  });

  test('onEvent(UpdateEmployeeEmail) updates employeeRequest email', () {
    notifier.state = notifier.state.copyWith(
      employeeRequest: EmployeeRequestModel(
        username: 'Alice',
        email: "sda@gmail.com",
        branchId: 1,
      ),
    );
    notifier.onEvent(UpdateEmployeeEmail('alice@example.com'));
    expect(notifier.state.employeeRequest?.email, 'alice@example.com');
  });

  test('onEvent(UpdateEmployeeBranch) updates employeeRequest branchId', () {
    notifier.state = notifier.state.copyWith(
      employeeRequest: EmployeeRequestModel(
        username: 'Alice',
        email: 'alice@example.com',
        branchId: 1,
      ),
    );
    notifier.onEvent(UpdateEmployeeBranch(2));
    expect(notifier.state.employeeRequest?.branchId, 2);
  });

  test('onEvent(SubmitEmployeeForm) calls addDoctorUseCase for Doctor', () async {
    notifier.state = notifier.state.copyWith(selectedRole: 'Doctor');


    expect(notifier.state.isLoading, false);
    expect(notifier.state.isSuccess, true);
    expect(notifier.state.error, null);
  });

  test('onEvent(SubmitEmployeeForm) calls addReceptionistUseCase for Receptionist', () async {
    notifier.state = notifier.state.copyWith(selectedRole: 'Receptionist');


    expect(notifier.state.isLoading, false);
    expect(notifier.state.isSuccess, true);
    expect(notifier.state.error, null);
  });

  test('onEvent(SubmitEmployeeForm) sets error on exception', () async {
    notifier.state = notifier.state.copyWith(selectedRole: 'Doctor');


    expect(notifier.state.isLoading, false);
    expect(notifier.state.isSuccess, false);
    expect(notifier.state.error, contains('Exception'));
  });
}