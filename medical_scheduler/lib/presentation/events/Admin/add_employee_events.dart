abstract class AddEmployeeEvent {}

class EmployeeRoleSelected extends AddEmployeeEvent {
  final String role; // "Doctor" or "Receptionist"
  EmployeeRoleSelected(this.role);
}

class SubmitEmployeeForm extends AddEmployeeEvent {
  final String? name; // Optional, for doctors
  final String email;
  final int branchId; // Assuming a default or selected branch ID

  SubmitEmployeeForm({this.name, required this.email, required this.branchId});
}
