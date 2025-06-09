import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  final storage = const FlutterSecureStorage();

  // In your widget:
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(authViewModelProvider.notifier).checkLoginStatus();
      if (!mounted) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
