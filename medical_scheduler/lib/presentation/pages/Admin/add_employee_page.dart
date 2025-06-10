import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/events/Admin/add_employee_events.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Admin/admin_provider.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';

class AddEmployeePage extends ConsumerStatefulWidget {
  final int branchId;

  const AddEmployeePage({super.key, required this.branchId});

  @override
  ConsumerState<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends ConsumerState<AddEmployeePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set initial branchId
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(addEmployeeNotifierProvider.notifier)
          .onEvent(UpdateEmployeeBranch(widget.branchId));
    });

    // Listen to text field changes to update state
    _nameController.addListener(() {
      ref
          .read(addEmployeeNotifierProvider.notifier)
          .onEvent(UpdateEmployeeName(_nameController.text));
    });

    _emailController.addListener(() {
      ref
          .read(addEmployeeNotifierProvider.notifier)
          .onEvent(UpdateEmployeeEmail(_emailController.text));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addEmployeeNotifierProvider);
    final notifier = ref.read(addEmployeeNotifierProvider.notifier);

    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Diagnosis added successfully!')),
        );
        notifier.state = notifier.state.copyWith(isSuccess: false);

        context.go('/admin_home');
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Role Selection
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
                    _nameController.clear(); // Reset name field
                  }
                },
              ),
              const SizedBox(height: 16),

              /// Name Field (Only for Doctor)
              if (state.selectedRole == 'Doctor') ...[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (state.selectedRole == 'Doctor' &&
                        (value == null || value.trim().isEmpty)) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],

              /// Email Field (Always required)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an email';
                  } else if (!value.contains('@')) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              /// Submit Button
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
                              name: state.selectedRole == 'Doctor'
                                  ? _nameController.text.trim()
                                  : "",
                              email: _emailController.text.trim(),
                              branchId: widget.branchId,
                            ),
                          );
                        }
                      },
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Add Employee'),
              ),
              const SizedBox(height: 20),

              /// Back to Home
              const BackToHome(roleId: 2),
            ],
          ),
        ),
      ),
    );
  }
}
