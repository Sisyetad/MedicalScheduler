import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/repository/user_repo.dart';

// The entity now holds the lists and the counts
class AdminDashboardData {
  final int doctorCount;
  final int receptionistCount;
  final List<User> employees; // <-- ADD THIS

  AdminDashboardData({
    required this.doctorCount,
    required this.receptionistCount,
    required this.employees, // <-- ADD THIS
  });
}

class GetAdminDashboardData {
  final UserRepo userRepository;

  GetAdminDashboardData(this.userRepository);

  Future<AdminDashboardData> call() async {
    final List<User> allUsers = await userRepository.getAllUsers();

    // Filter for only doctors and receptionists
    final employees = allUsers
        .where((user) => user.role.roleId == 4 || user.role.roleId == 5)
        .toList();

    // Calculate counts from the filtered list
    final int doctorCount = employees
        .where((user) => user.role.roleId == 4)
        .length;
    final int receptionistCount = employees
        .where((user) => user.role.roleId == 5)
        .length;

    // Return the complete data object
    return AdminDashboardData(
      doctorCount: doctorCount,
      receptionistCount: receptionistCount,
      employees: employees,
    );
  }
}
