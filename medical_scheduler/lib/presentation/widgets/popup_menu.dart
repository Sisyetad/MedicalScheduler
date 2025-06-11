import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton<String>(
        // This is the correct way to handle item taps
        onSelected: (String value) {
          if (value == 'view') {
            context.go('/profile');
          } else if (value == 'edit') {
            context.go('/profile/edit'); // Example route for editing
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<String>(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.black),
                  SizedBox(width: 8),
                  Text('View Profile'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Edit Profile'),
                ],
              ),
            ),
          ];
        },
        // The child is now just the CircleAvatar.
        // The PopupMenuButton makes it tappable automatically.
        child: CircleAvatar(
          child: Image.asset('assets/images/profile.png'), // Profile image
        ),
      ),
    );
  }
}
