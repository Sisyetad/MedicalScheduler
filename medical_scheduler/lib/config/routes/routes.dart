import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/home_page.dart';
import 'package:medical_scheduler/presentation/pages/Admin/add_employee_page.dart';
import 'package:medical_scheduler/presentation/pages/Admin/admin_dashboard_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/add_diagnosis_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/diagnosis_detail_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/doctor_queue_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/patient_history_page.dart';
import 'package:medical_scheduler/presentation/pages/Auth/profile_page.dart';
import 'package:medical_scheduler/presentation/pages/Auth/signup_login_page.dart';
import 'package:medical_scheduler/presentation/pages/Receptionist/receptionist_queue.dart';
import 'package:medical_scheduler/presentation/pages/Receptionist/add_patient_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(authViewModelProvider.select((s) => s.user));

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final user = ref.watch(authViewModelProvider.select((s) => s.user));
      final isChecking = ref.watch(
        authViewModelProvider.select((s) => s.isLoading),
      );
      final loggingIn = state.uri.toString() == '/auth';

      if (isChecking) return null;

      if (user == null && !loggingIn) {
        return '/auth';
      }

      if (user != null && (loggingIn || state.uri.toString() == '/')) {
        final roleId = user.role.roleId;
        switch (roleId) {
          case 4: // Doctor
            return '/doctor_queue';
          case 5: // Receptionist
            return '/receptionist/queue';
          case 2: // Admin
            return '/admin_home';
          default:
            return '/doctor_queue';
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),

      /// Auth
      GoRoute(
        path: '/auth',
        builder: (context, state) => const LoginSignUpPage(),
      ),

      /// Profile
      GoRoute(path: '/profile', builder: (context, state) => const Profile()),
      GoRoute(
        path: '/edit_profile',
        builder: (context, state) => const Profile(),
      ),

      /// Admin
      GoRoute(
        path: '/admin_home',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: '/add_employee/:branchId',
        builder: (context, state) {
          final branchId = int.parse(state.pathParameters['branchId']!);
          return AddEmployeePage(branchId: branchId);
        },
      ),

      /// Doctor
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

      /// Receptionist
      GoRoute(
        path: '/receptionist/queue',
        builder: (context, state) => const ReceptionistQueuePage(),
      ),
      GoRoute(
        path: '/receptionist/add-patient/:registerId',
        builder: (context, state) {
          final registerdBId = int.parse(state.pathParameters['registerId']!);
          return AddPatientPage(receptionistId: registerdBId);
        },
      ),
    ],
  );
});
