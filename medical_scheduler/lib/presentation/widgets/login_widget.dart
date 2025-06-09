import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart';
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  late final ProviderSubscription<AuthUiState> _authListener;

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
    _authListener.close();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = ref.watch(authViewModelProvider.select((s) => s.error));
    final isLoading = ref.watch(
      authViewModelProvider.select((s) => s.isLoading),
    );
    final authViewModel = ref.read(authViewModelProvider.notifier);

    return Column(
      children: [
        RoleDropdown(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: TextField(
            controller: controllerEmail,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: TextField(
            controller: controllerPassword,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error, style: const TextStyle(color: Colors.red)),
          ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: isLoading
              ? null
              : () => authViewModel.onEvent(
                  SubmitLogin(
                    email: controllerEmail.text,
                    password: controllerPassword.text,
                  ),
                ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFF2751C3),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
        ),
      ],
    );
  }
}
