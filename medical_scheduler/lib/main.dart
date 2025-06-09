import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/config/routes/routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Medical Scheduler',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: router, // ✅ Use reactive router
    );
  }
}

// 🎨 Custom ThemeData
final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF1A73E8),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: const InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1A73E8),
    secondary: Color.fromARGB(255, 162, 182, 202),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  useMaterial3: true,
);
