import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/events/Admin/admin_dashboard_events.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Admin/admin_provider.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(adminDashboardNotifierProvider.notifier)
          .onEvent(FetchDashboardData()),
    );
  }

  void _showDeleteConfirmation(int userId, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete user: $username?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () {
                ref
                    .read(adminDashboardNotifierProvider.notifier)
                    .onEvent(DeleteEmployee(userId));
                Navigator.of(context).pop();
              },
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

    // --- 2. GET THE CURRENTLY LOGGED-IN USER ---
    final currentUser = ref.watch(authViewModelProvider.select((s) => s.user));

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        // --- 3. ADD THE ACTIONS TO THE APPBAR ---
        actions: [
          if (currentUser != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () {
                  // Navigate to the full profile page when tapped
                  context.go('/profile');
                },
                child: CircleAvatar(
                  // Using a simple icon for the avatar as in the figma
                  backgroundColor: Colors.white,
                  // Using a simple icon for the avatar as in the figma
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          else
            const SizedBox.shrink(), // Or a loading indicator
        ],
      ),
      body: state.isLoading && state.allEmployees.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => notifier.onEvent(FetchDashboardData()),
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Stat Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Total Doctors',
                          count: state.doctorCount,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Total Receptionists',
                          count: state.receptionistCount,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Add Employee Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Employee'),
                    onPressed: () {
                      context.go('/add_employee/${currentUser?.userId}');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Search Bar
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search for Employee ...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) =>
                        notifier.onEvent(SearchEmployees(query)),
                  ),
                  const SizedBox(height: 16),

                  // Employee Table
                  DataTable(
                    headingRowColor: WidgetStateProperty.all(
                      // ignore: deprecated_member_use
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    ),
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Role')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: state.displayedEmployees.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text(user.username)),
                          DataCell(Text(user.role.name)),
                          DataCell(
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => _showDeleteConfirmation(
                                user.userId,
                                user.username,
                              ),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required int count,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
