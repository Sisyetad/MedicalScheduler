import 'package:flutter/material.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;

  const ProfileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F9FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/profile.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            user.username,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
