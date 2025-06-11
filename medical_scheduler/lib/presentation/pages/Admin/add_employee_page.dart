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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Employee added successfully!')));
        // ignore: invalid_use_of_protected_member
        notifier.state = notifier.state.copyWith(isSuccess: false);

        context.go('/admin_home');
      });
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.tertiary),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[50],
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add Employee',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if (state.selectedRole == 'Doctor') ...[
                  const SizedBox(height: 20),
                  TextFormField(
                    key: const Key('add_employee_name_field'),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (state.selectedRole == 'Doctor' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ],
                TextFormField(
                  key: const Key('add_employee_email_field'),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
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
                const SizedBox(height: 20),
                const Text('Select Role', style: TextStyle(fontSize: 16)),
                DropdownButtonFormField<String>(
                  key: const Key('add_employee_role_dropdown'),
                  value: state.selectedRole,
                  decoration: const InputDecoration(
                    hintText: 'Select Role',
                    border: UnderlineInputBorder(),
                  ),
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
                const SizedBox(height: 32),
                ElevatedButton(
                  key: const Key('add_employee_submit_button'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue[700],
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
                      : const Text(
                          'Add Employee',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
                const SizedBox(height: 20),
                // Optionally add a key for BackToHome
                const BackToHome(
                  roleId: 2,
                  key: Key('add_employee_back_home_button'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
