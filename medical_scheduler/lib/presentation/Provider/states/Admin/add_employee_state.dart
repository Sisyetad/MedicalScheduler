class AddEmployeeState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String selectedRole; // "Doctor" or "Receptionist"

  AddEmployeeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.selectedRole = 'Doctor', // Default role
  });

  AddEmployeeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? selectedRole,
  }) {
    return AddEmployeeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}
