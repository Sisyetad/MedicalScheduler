import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.black),
                  SizedBox(width: 8),
                  Text('View Profile'),
                ],
              ),
            ),
            PopupMenuItem<String>(
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
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {// Optionally, you can handle tap here for custom behavior
          },
          child: CircleAvatar(
            child: Image.asset('assets/images/profile.png'), // Profile image
          ),
        ),
      ),
    );
  }
}
