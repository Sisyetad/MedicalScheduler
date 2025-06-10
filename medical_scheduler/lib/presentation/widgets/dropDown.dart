import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Common/role_provider.dart';

class RoleDropdown extends ConsumerWidget {
  const RoleDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.watch(roleProvider);

    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      items: const [
        DropdownMenuItem(value: null, child: Text('Select Role')),
        DropdownMenuItem(value: 'doctor', child: Text('Doctor')),
        DropdownMenuItem(value: 'receptionist', child: Text('Receptionist')),
        DropdownMenuItem(value: 'admin', child: Text('Admin')),
      ],
      onChanged: (value) {
        ref.read(roleProvider.notifier).state = value;
      },
      validator: (value) => value == null ? 'Please select a role' : null,
    );
  }
}
