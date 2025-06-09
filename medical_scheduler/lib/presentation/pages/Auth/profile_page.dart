import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';
import 'package:medical_scheduler/presentation/widgets/edit_profile_widget.dart';
import 'package:medical_scheduler/presentation/widgets/popup_menu.dart';
import 'package:medical_scheduler/presentation/widgets/profile_widget.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  bool isProfile = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    final user = state.user;

    return SafeArea(
      child: Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          actions: const [PopupMenu()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => setState(() => isProfile = true),
                        child: const Text('Profile'),
                      ),
                      TextButton(
                        onPressed: () => setState(() => isProfile = false),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (user != null)
                    isProfile
                        ? ProfileWidget(user: user)
                        : const EditProfileWidget()
                  else
                    const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 20),
                  BackToHome(roleId: user!.role.roleId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
