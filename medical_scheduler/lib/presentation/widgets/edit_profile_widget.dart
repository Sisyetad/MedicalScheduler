import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/user_profile_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/edit_profile_ui_state.dart';
import 'package:medical_scheduler/presentation/events/Auth/profile_edit_event.dart';

class EditProfileWidget extends ConsumerStatefulWidget {
  const EditProfileWidget({super.key});

  @override
  ConsumerState<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends ConsumerState<EditProfileWidget> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _hasLoadedProfile = false;

  @override
  void initState() {
    super.initState();
    print('EditProfileWidget initState'); // Debug
    // Defer loadUserProfile to avoid modifying provider during widget lifecycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        print('Calling loadUserProfile'); // Debug
        ref.read(editProfileViewModelProvider.notifier).loadUserProfile();
        setState(() {
          _hasLoadedProfile = true;
        });
      });
    });
  }

  @override
  void dispose() {
    print('EditProfileWidget dispose'); // Debug
    // Dispose controllers to prevent memory leaks
    usernameController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('EditProfileWidget build'); // Debug
    final state = ref.watch(editProfileViewModelProvider);
    final viewModel = ref.read(editProfileViewModelProvider.notifier);

    // Listen to state changes to update controllers
    ref.listen<EditProfileUiState>(editProfileViewModelProvider, (
      previous,
      next,
    ) {
      print(
        'State changed: username=${next.username}, email=${next.email}',
      ); // Debug
      if (_hasLoadedProfile &&
          next.username != previous?.username &&
          next.username.isNotEmpty) {
        usernameController.text = next.username;
      }
      if (_hasLoadedProfile &&
          next.email != previous?.email &&
          next.email.isNotEmpty) {
        emailController.text = next.email;
      }
      if (next.currentPassword != previous?.currentPassword &&
          next.currentPassword.isNotEmpty) {
        currentPasswordController.text = next.currentPassword;
      }
      if (next.newPassword != previous?.newPassword &&
          next.newPassword.isNotEmpty) {
        newPasswordController.text = next.newPassword;
      }
      if (next.confirmPassword != previous?.confirmPassword &&
          next.confirmPassword.isNotEmpty) {
        confirmPasswordController.text = next.confirmPassword;
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.isLoading) const Center(child: CircularProgressIndicator()),
        if (state.error != null)
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              state.error!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        if (state.isSuccess)
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Profile updated successfully!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'User Name'),
            onChanged: (value) {
              print('Username changed: $value'); // Debug
              viewModel.onEvent(UpdateUserName(value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            onChanged: (value) {
              print('Email changed: $value'); // Debug
              viewModel.onEvent(UpdateEmail(value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: currentPasswordController,
            decoration: const InputDecoration(labelText: 'Enter Password'),
            obscureText: true,
            onChanged: (value) {
              print('Current password changed'); // Debug
              viewModel.onEvent(UpdateCurrentPassword(value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: newPasswordController,
            decoration: const InputDecoration(labelText: 'New Password'),
            obscureText: true,
            onChanged: (value) {
              print('New password changed'); // Debug
              viewModel.onEvent(UpdateNewPassword(value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: confirmPasswordController,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            onChanged: (value) {
              print('Confirm password changed'); // Debug
              viewModel.onEvent(UpdateConfirmPassword(value));
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: OutlinedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    print('Update button pressed'); // Debug
                    viewModel.onEvent(
                      SubmitProfileUpdate(
                        username: usernameController.text,
                        email: emailController.text,
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text,
                      ),
                    );
                  },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color.fromARGB(255, 39, 81, 195),
            ),
            child: const Center(
              child: Text(
                "Update",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
