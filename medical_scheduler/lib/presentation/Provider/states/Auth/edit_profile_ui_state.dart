class EditProfileUiState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  final String username;
  final String email;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  EditProfileUiState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.username = '',
    this.email = '',
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  EditProfileUiState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? username,
    String? email,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return EditProfileUiState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      username: username ?? this.username,
      email: email ?? this.email,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
