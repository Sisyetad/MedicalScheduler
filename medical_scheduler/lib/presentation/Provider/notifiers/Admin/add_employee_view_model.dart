import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/Application/Usecases/doctor/add_doctor.dart';
import 'package:medical_scheduler/Application/Usecases/receptionist/add_receptionist.dart';
import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';
import 'package:medical_scheduler/domain/entities/request/receptionist_request.dart';
import 'package:medical_scheduler/presentation/events/Admin/add_employee_events.dart';
import 'package:medical_scheduler/presentation/Provider/states/Admin/add_employee_state.dart';

class AddEmployeeNotifier extends StateNotifier<AddEmployeeState> {
  final AddDoctor _addDoctorUseCase;
  final AddReceptionist _addReceptionistUseCase;

  AddEmployeeNotifier(this._addDoctorUseCase, this._addReceptionistUseCase)
    : super(AddEmployeeState());

  Future<void> onEvent(AddEmployeeEvent event) async {
    if (event is EmployeeRoleSelected) {
      state = state.copyWith(
        selectedRole: event.role,
        isSuccess: false,
        error: null,
      );
    } else if (event is SubmitEmployeeForm) {
      await _submitForm(event);
    }
  }

  Future<void> _submitForm(SubmitEmployeeForm event) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      if (state.selectedRole == 'Doctor') {
        if (event.name == null || event.name!.isEmpty) {
          throw Exception('Doctor name is required.');
        }
        final doctorRequest = DoctorRequest(
          username: event.name!,
          email: event.email,
          branchId: event.branchId,
        );
        await _addDoctorUseCase.call(
          CreateDoctorParams(doctorRequest: doctorRequest),
        );
      } else {
        final receptionistRequest = ReceptionistRequest(
          email: Stream.value(event.email),
          branchId: event.branchId,
        );
        await _addReceptionistUseCase.call(
          CreateReceptionistParams(receptionistRequest: receptionistRequest),
        );
      }
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
