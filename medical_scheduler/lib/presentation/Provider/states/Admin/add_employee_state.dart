import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';

class AddEmployeeState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String selectedRole; // "Doctor" or "Receptionist"
  final EmployeeRequest? employeeRequest;

  AddEmployeeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.selectedRole = 'Doctor',
    this.employeeRequest, // Default role
  });

  AddEmployeeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? selectedRole,
    EmployeeRequest? employeeRequest,
  }) {
    return AddEmployeeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      selectedRole: selectedRole ?? this.selectedRole,
      employeeRequest: employeeRequest ?? this.employeeRequest,
    );
  }
}
