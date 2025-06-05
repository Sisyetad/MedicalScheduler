import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/auth_provider.dart';
import 'package:medical_scheduler/presentation/events/auth_events.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);
    
    return Column(
      children: [
        RoleDropdown(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: TextField(
            controller: controllerEmail,
            onChanged: (value) => authViewModel.onEvent(UpdateEmail(value)),
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: TextField(
            controller: controllerPassword,
            obscureText: true,
            onChanged: (value) => authViewModel.onEvent(UpdatePassword(value)),
            decoration: const InputDecoration(labelText: 'Password'),
          ),
        ),
        if (authState.error != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              authState.error!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed:
              authState.isLoading
                  ? null
                  : () => authViewModel.onEvent(SubmitLogin(context)),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFF2751C3),
          ),
          child:
              authState.isLoading
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
