import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/doctor/add_doctor.dart';
import 'package:medical_scheduler/Application/Usecases/receptionist/add_receptionist.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/presentation/Provider/states/Admin/add_employee_state.dart';
import 'package:medical_scheduler/presentation/events/Admin/add_employee_events.dart';

class AddEmployeeNotifier extends StateNotifier<AddEmployeeState> {
  final AddDoctor addDoctorUseCase;
  final AddReceptionist addReceptionistUseCase;

  AddEmployeeNotifier({
    required this.addDoctorUseCase,
    required this.addReceptionistUseCase,
  }) : super(AddEmployeeState());

  void onEvent(AddEmployeeEvent event) async {
    if (event is EmployeeRoleSelected) {
      state = state.copyWith(selectedRole: event.role);
    } else if (event is UpdateEmployeeName) {
      state = state.copyWith(
        employeeRequest: state.employeeRequest?.copyWith(username: event.name),
      );
    } else if (event is UpdateEmployeeEmail) {
      state = state.copyWith(
        employeeRequest: state.employeeRequest?.copyWith(email: event.email),
      );
    } else if (event is UpdateEmployeeBranch) {
      state = state.copyWith(
        employeeRequest: state.employeeRequest?.copyWith(
          branchId: event.branchId,
        ),
      );
    } else if (event is SubmitEmployeeForm) {
      await _handleSubmit(event);
    }
  }

  Future<void> _handleSubmit(SubmitEmployeeForm event) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = EmployeeRequestModel(
        username: event.name,
        email: event.email,
        branchId: event.branchId,
      );
      if (state.selectedRole == 'Doctor') {
        await addDoctorUseCase.call(CreateDoctorParams(doctorRequest: request));
      } else {
        await addReceptionistUseCase(
          CreateReceptionistParams(receptionistRequest: request),
        );
      }

      state = state.copyWith(isLoading: false, isSuccess: true);
      print(state.isSuccess);
    } catch (e) {
      print('Error during submission: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
