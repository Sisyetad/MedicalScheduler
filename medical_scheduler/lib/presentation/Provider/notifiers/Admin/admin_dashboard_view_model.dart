import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/Application/Usecases/admin/get_admin_dashboard_data.dart';
import 'package:medical_scheduler/Application/Usecases/user/delete_user.dart';
import 'package:medical_scheduler/presentation/events/Admin/admin_dashboard_events.dart';
import 'package:medical_scheduler/presentation/Provider/states/Admin/admin_dashboard_state.dart';

class AdminDashboardNotifier extends StateNotifier<AdminDashboardState> {
  final GetAdminDashboardData _getAdminDashboardData;
  final DeleteUser _deleteUser;

  AdminDashboardNotifier(this._getAdminDashboardData, this._deleteUser)
    : super(AdminDashboardState());

  Future<void> onEvent(AdminDashboardEvent event) async {
    if (event is FetchDashboardData) {
      await _fetchData();
    } else if (event is SearchEmployees) {
      _searchEmployees(event.query);
    } else if (event is DeleteEmployee) {
      await _deleteEmployee(event.userId);
    }
  }

  Future<void> _fetchData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await _getAdminDashboardData.call();
      state = state.copyWith(
        isLoading: false,
        doctorCount: data.doctorCount,
        receptionistCount: data.receptionistCount,
        allEmployees: data.employees,
        displayedEmployees: data.employees, // Initially, display all
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _searchEmployees(String query) {
    if (query.isEmpty) {
      // If search is empty, show all employees
      state = state.copyWith(displayedEmployees: state.allEmployees);
    } else {
      // Otherwise, filter the master list
      final filteredList = state.allEmployees
          .where(
            (user) => user.username.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      state = state.copyWith(displayedEmployees: filteredList);
    }
  }

  Future<void> _deleteEmployee(int userId) async {
    try {
      await _deleteUser.call(userId);
      await _fetchData();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}
