import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Common/role_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart';
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';

class SignupWidget extends ConsumerStatefulWidget {
  const SignupWidget({super.key});

  @override
  ConsumerState<SignupWidget> createState() => _BuildsignupState();
}

class _BuildsignupState extends ConsumerState<SignupWidget> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPw = TextEditingController();
  TextEditingController controllerCP = TextEditingController();
  late final ProviderSubscription<AuthUiState> _authListener;
  String? _passwordError; // For password mismatch error

  @override
  void initState() {
    super.initState();
    _authListener = ref.listenManual<AuthUiState>(authViewModelProvider, (
      prev,
      next,
    ) {
      if (next.user != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          final roleId = next.user!.role.roleId;
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
        });
      }
    });
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPw.dispose();
    controllerCP.dispose();
    _authListener.close(); // Close listener to prevent leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = ref.watch(authViewModelProvider.select((s) => s.error));
    final isLoading = ref.watch(
      authViewModelProvider.select((s) => s.isLoading),
    );
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final selectedRole = ref.watch(roleProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: TextField(
              controller: controllerName,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ),
          RoleDropdown(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: TextField(
              controller: controllerEmail,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: TextField(
              controller: controllerPw,
              decoration: const InputDecoration(labelText: 'Enter Password'),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: TextField(
              controller: controllerCP,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: _passwordError,
              ),
              obscureText: true,
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton(
              key: const Key('signup_button'),
              onPressed: isLoading
                  ? null
                  : () {
                      // Validate inputs
                      if (controllerName.text.isEmpty ||
                          controllerEmail.text.isEmpty ||
                          controllerPw.text.isEmpty ||
                          controllerCP.text.isEmpty ||
                          selectedRole == null) {
                        setState(() {
                          _passwordError = 'Please fill all fields';
                        });
                        return;
                      }
                      if (controllerPw.text != controllerCP.text) {
                        setState(() {
                          _passwordError = 'Passwords do not match';
                        });
                        return;
                      }
                      setState(() {
                        _passwordError = null;
                      });
                      authViewModel.onEvent(
                        SubmitSignup(
                          username: controllerName.text,
                          email: controllerEmail.text,
                          password: controllerPw.text,
                          role: selectedRole,
                        ),
                      );
                    },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 39, 81, 195),
                disabledBackgroundColor: Colors.grey,
              ),
              child: const Center(
                child: Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
