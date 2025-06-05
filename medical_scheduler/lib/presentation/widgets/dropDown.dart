import 'package:flutter/material.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({super.key});

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: [
        DropdownMenuItem(value: null, child: Text('Select Role')),
        DropdownMenuItem(value: 'Doctor', child: Text('Doctor')),
        DropdownMenuItem(value: 'Receptionist', child: Text('Receptionist')),
        DropdownMenuItem(value: 'Admin', child: Text('Admin')),
      ],
      onChanged: (value) {
        setState(() {
          selectedRole = value;
        });
      },
    );
  }
}
