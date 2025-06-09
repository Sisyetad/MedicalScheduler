import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/home_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/add_diagnosis_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/diagnosis_detail_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/doctor_queue_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/patient_history_page.dart';
import 'package:medical_scheduler/presentation/pages/Auth/profile_page.dart';
import 'package:medical_scheduler/presentation/pages/Auth/signup_login_page.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authViewModelProvider.notifier).stream,
    ),
    redirect: (context, state) {
      final loggedIn = authState.user != null;
      final loggingIn = state.uri.toString() == '/auth';

      if (!loggedIn && !loggingIn) {
        return '/auth';
      }

      if (loggedIn && loggingIn) {
        final roleId = authState.user?.role.roleId;
        switch (roleId) {
          case 4:
            return '/doctor_queue';
          case 5:
            return '/receptionist_home';
          case 2:
            return '/admin_home';
          default:
            return '/doctor_queue';
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const LoginSignUpPage(),
      ),
      GoRoute(
        path: '/doctor_queue',
        builder: (context, state) => const DoctorPage(),
      ),
      GoRoute(
        path: '/patient_history/:patientId',
        builder: (context, state) {
          final patientId = int.parse(state.pathParameters['patientId']!);
          return PatientHistoryPage(patientId: patientId);
        },
      ),
      GoRoute(
        path: '/diagnosis_detail/:diagnosisId',
        builder: (context, state) {
          final diagnosisId = int.parse(state.pathParameters['diagnosisId']!);
          return DiagnosisSummaryScreen(diagnosisId: diagnosisId);
        },
      ),
      GoRoute(
        path: '/diagnosis_form/:patientId',
        builder: (context, state) {
          final patientId = int.parse(state.pathParameters['patientId']!);
          return AddDiagnosisScreen(patientId: patientId);
        },
      ),
      GoRoute(path: '/profile', builder: (context, state) => const Profile()),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
