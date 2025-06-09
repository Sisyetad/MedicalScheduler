abstract class AdminDashboardEvent {}

class FetchDashboardData extends AdminDashboardEvent {}

class SearchEmployees extends AdminDashboardEvent {
  final String query;
  SearchEmployees(this.query);
}

class DeleteEmployee extends AdminDashboardEvent {
  final int userId;
  DeleteEmployee(this.userId);
}
