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

class UpdateEmployeeName extends AddEmployeeEvent {
  final String name;
  UpdateEmployeeName(this.name);
}

class UpdateEmployeeEmail extends AddEmployeeEvent {
  final String email;
  UpdateEmployeeEmail(this.email);
}

class UpdateEmployeeBranch extends AddEmployeeEvent {
  final int branchId;
  UpdateEmployeeBranch(this.branchId);
}
