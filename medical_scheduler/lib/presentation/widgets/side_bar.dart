import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/core/constants/themeConstants.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/notifiers.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({super.key});

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 0, 52, 102),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.menu, color: Colors.white),
            title: const Text(
              'Medicare',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () async {
              await ref.read(authViewModelProvider.notifier).logout();
              if (context.mounted) context.go('/auth');
            },
          ),
          // Theme toggle remains the same
          ListTile(
            leading: IconButton(
              onPressed: () async {
                isDarkModeNotifier.value = !isDarkModeNotifier.value;
                final SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.setBool(
                  Kconstants.themeModeKey,
                  isDarkModeNotifier.value,
                );
              },
              icon: ValueListenableBuilder(
                valueListenable: isDarkModeNotifier,
                builder: (context, isDarkMode, child) {
                  return Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: const Color.fromARGB(255, 245, 245, 247),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
