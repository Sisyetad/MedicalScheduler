import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/home_page.dart';
import 'package:medical_scheduler/presentation/pages/add_diagnosis_page.dart';
import 'package:medical_scheduler/presentation/pages/diagnosis_detail_page.dart';
import 'package:medical_scheduler/presentation/pages/doctor_queue_page.dart';
import 'package:medical_scheduler/presentation/pages/patient_history_page.dart';
import 'package:medical_scheduler/presentation/pages/profile_page.dart';
import 'package:medical_scheduler/presentation/pages/signup_login_page.dart';

final router = GoRouter(
  initialLocation: '/',
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
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return Profile();
      },
    ),
  ],
);
