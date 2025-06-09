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
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 330,
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(154, 240, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isProfile = false),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: !isProfile
                                        ? const Color(0xFF2751C3)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: !isProfile
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isProfile = true),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isProfile
                                        ? const Color(0xFF2751C3)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: isProfile
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
