import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medical_scheduler/main.dart' as app;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/doctor_queue_page.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sign-up Flow E2E Test', () {
    testWidgets('Sign up as Doctor and log out', (WidgetTester tester) async {
      // Step 1: Launch the app
      await tester.pumpWidget(const ProviderScope(child: app.MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Switch to sign-up mode
      final signupToggle = find.byKey(const Key('signup_toggle_button'));
      expect(
        signupToggle,
        findsOneWidget,
        reason: "Sign-up toggle button should be present.",
      );
      await tester.tap(signupToggle);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Fill in the sign-up form
      await tester.enterText(find.byKey(const Key('signup_name_field')), 'Test Doctor');
      await tester.enterText(find.byKey(const Key('signup_email_field')), 'doctor.test@medicare.com');
      await tester.enterText(find.byKey(const Key('signup_password_field')), 'securepassword123');
      await tester.enterText(find.byKey(const Key('signup_confirm_password_field')), 'securepassword123');
      await tester.pumpAndSettle();

      // Select Doctor role from dropdown
      final roleDropdown = find.byKey(const Key('signup_role_dropdown'));
      expect(
        roleDropdown,
        findsOneWidget,
        reason: "Role dropdown should be present",
      );
      await tester.tap(roleDropdown);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find and tap the Doctor option in the dropdown menu
      final doctorOption = find.text('Doctor').last;
      expect(
        doctorOption,
        findsOneWidget,
        reason: "Doctor option should be present in dropdown",
      );
      await tester.tap(doctorOption);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Submit the form
      final signupButton = find.byKey(const Key('signup_submit_button'));
      expect(
        signupButton,
        findsOneWidget,
        reason: "Sign-up button should be present",
      );
      await tester.tap(signupButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify we're on the Doctor page
      expect(find.byType(DoctorPage), findsOneWidget, reason: 'Should be on Doctor page after sign-up');
      expect(find.byKey(const Key('doctor_queue_title')), findsOneWidget, reason: 'Doctor queue title should be present');
      expect(find.byKey(const Key('doctor_appbar')), findsOneWidget, reason: 'Doctor app bar should be present');

      // Logout
      final menuIcon = find.byIcon(Icons.menu);
      expect(
        menuIcon,
        findsOneWidget,
        reason: "Menu icon should be present",
      );
      await tester.tap(menuIcon);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final logoutButton = find.text('Logout');
      expect(
        logoutButton,
        findsOneWidget,
        reason: "Logout button should be present in menu",
      );
      await tester.tap(logoutButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
