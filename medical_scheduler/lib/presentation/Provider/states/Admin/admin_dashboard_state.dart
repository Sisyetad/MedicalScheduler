import 'package:medical_scheduler/domain/entities/response/user.dart';

class AdminDashboardState {
  final bool isLoading;
  final String? error;
  final int doctorCount;
  final int receptionistCount;
  final List<User> allEmployees; // Full list from server
  final List<User>
  displayedEmployees; // List to show in table (can be filtered)

  AdminDashboardState({
    this.isLoading = false,
    this.error,
    this.doctorCount = 0,
    this.receptionistCount = 0,
    this.allEmployees = const [],
    this.displayedEmployees = const [],
  });

  AdminDashboardState copyWith({
    bool? isLoading,
    String? error,
    int? doctorCount,
    int? receptionistCount,
    List<User>? allEmployees,
    List<User>? displayedEmployees,
  }) {
    return AdminDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      doctorCount: doctorCount ?? this.doctorCount,
      receptionistCount: receptionistCount ?? this.receptionistCount,
      allEmployees: allEmployees ?? this.allEmployees,
      displayedEmployees: displayedEmployees ?? this.displayedEmployees,
    );
  }
}
