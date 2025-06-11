import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/events/Admin/admin_dashboard_events.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Admin/admin_provider.dart';
import 'package:medical_scheduler/presentation/widgets/popup_menu.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';

// ...imports...

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(adminDashboardNotifierProvider.notifier).onEvent(FetchDashboardData());
    });
  }

  void _filterEmployees(String query) {
    ref.read(adminDashboardNotifierProvider.notifier).onEvent(SearchEmployees(query));
  }

  void _showDeleteConfirmation(int userId, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $username?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(adminDashboardNotifierProvider.notifier).onEvent(DeleteEmployee(userId));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminDashboardNotifierProvider);
    final notifier = ref.read(adminDashboardNotifierProvider.notifier);
    final currentUser = ref.watch(authViewModelProvider.select((s) => s.user));

    return SafeArea(
      child: Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          actions: const [PopupMenu()],
        ),
        body: state.isLoading && state.allEmployees.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => notifier.onEvent(FetchDashboardData()),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Admin Dashboard",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Consumer(
                            builder: (context, ref, child) => _buildStatCard(
                              title: 'Total Doctors',
                              count: state.doctorCount,
                              icon: Icons.medical_services,
                              key: const Key('dashboard_total_doctors_card'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Consumer(
                            builder: (context, ref, child) => _buildStatCard(
                              title: 'Total Receptionists',
                              count: state.receptionistCount,
                              icon: Icons.support_agent,
                              key: const Key(
                                'dashboard_total_receptionists_card',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SearchBar(
                        key: const Key('dashboard_employee_search_field'),
                        hintText: "Search for Employee ...",
                        onChanged: _filterEmployees,
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton.icon(
                        key: const Key('add_employee_button'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Employee'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            39,
                            81,
                            195,
                          ),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          context.go('/add_employee/${currentUser?.userId}');
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor:
                                WidgetStateProperty.resolveWith<Color?>(
                                  (states) =>
                                      const Color.fromARGB(255, 43, 95, 145),
                                ),
                            headingRowHeight: 40,
                            dataRowHeight: 120,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Role',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                            rows: state.displayedEmployees.map((user) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(user.username)),
                                  DataCell(Text(user.role.name)),
                                  DataCell(
                                    SizedBox(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 26,
                                            child: ElevatedButton(
                                              key: Key(
                                                'delete_user_button_${user.userId}',
                                              ),
                                              onPressed: () =>
                                                  _showDeleteConfirmation(
                                                    user.userId,
                                                    user.username,
                                                  ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFF2B5F91,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            border: TableBorder.all(
                              color: Colors.grey,
                              width: 1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required int count,
    required IconData icon,
    Key? key,
  }) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2B5F91),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
