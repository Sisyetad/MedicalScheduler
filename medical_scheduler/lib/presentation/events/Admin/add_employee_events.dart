abstract class AddEmployeeEvent {}

class EmployeeRoleSelected extends AddEmployeeEvent {
  final String role;
  EmployeeRoleSelected(this.role);
}

class SubmitEmployeeForm extends AddEmployeeEvent {
  final String? name;
  final String email;
  final int branchId;

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
