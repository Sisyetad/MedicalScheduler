import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/events/Admin/add_employee_events.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Admin/admin_provider.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';

class AddEmployeePage extends ConsumerStatefulWidget {
  const AddEmployeePage({super.key});

  @override
  ConsumerState<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends ConsumerState<AddEmployeePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addEmployeeNotifierProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee Added Successfully!')),
        );
        context.pop();
      } else if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${next.error}')));
      }
    });

    final state = ref.watch(addEmployeeNotifierProvider);
    final notifier = ref.read(addEmployeeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Role Dropdown
              DropdownButtonFormField<String>(
                value: state.selectedRole,
                decoration: const InputDecoration(labelText: 'Role'),
                items: ['Doctor', 'Receptionist']
                    .map(
                      (role) =>
                          DropdownMenuItem(value: role, child: Text(role)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    notifier.onEvent(EmployeeRoleSelected(value));
                  }
                },
              ),
              const SizedBox(height: 16),

              // Name field (only for Doctors)
              if (state.selectedRole == 'Doctor')
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              if (state.selectedRole == 'Doctor') const SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: state.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          notifier.onEvent(
                            SubmitEmployeeForm(
                              name: _nameController.text,
                              email: _emailController.text,
                              branchId: 1, // Default branch ID
                            ),
                          );
                        }
                      },
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Add Employee'),
              ),

              const SizedBox(height: 20),

              // Back to Home
              const BackToHome(roleId: 2), // 2 = Admin
            ],
          ),
        ),
      ),
    );
  }
}
