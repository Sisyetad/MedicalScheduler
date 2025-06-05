import 'package:flutter/material.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;

  const ProfileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: 295,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(154, 229, 249, 255),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: Image.asset(
              'assets/images/profile.png',
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 12),
          Text(user.username, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
