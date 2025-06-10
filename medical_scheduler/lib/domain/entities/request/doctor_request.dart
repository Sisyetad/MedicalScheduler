class EmployeeRequest {
  final String? username;
  final String email;
  final int branchId;

  EmployeeRequest({this.username, required this.email, required this.branchId});

  EmployeeRequest copyWith({String? username, String? email, int? branchId}) {
    return EmployeeRequest(
      username: username ?? this.username,
      email: email ?? this.email,
      branchId: branchId ?? this.branchId,
    );
  }
}
