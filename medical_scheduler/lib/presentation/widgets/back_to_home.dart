import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackToHome extends StatelessWidget {
  final int roleId;
  const BackToHome({super.key, required this.roleId});

  @override
  Widget build(BuildContext context, ) {
    return OutlinedButton(
      onPressed: () => _navigateBasedOnRole( context, roleId),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color.fromARGB(255, 108, 117, 125),
      ),
      child: Text(
        'Back To Home',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

void _navigateBasedOnRole(BuildContext context, int roleId) {
  switch (roleId) {
    case 4:
      context.go('/doctor_queue');
      break;
    case 5:
      context.go('/receptionist_home');
      break;
    case 2:
      context.go('/admin_home');
      break;
    default:
      context.go('/auth');
  }
}
}