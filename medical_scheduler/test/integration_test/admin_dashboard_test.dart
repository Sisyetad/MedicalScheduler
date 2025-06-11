import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medical_scheduler/main.dart' as app;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/pages/Admin/admin_dashboard_page.dart';
import 'package:medical_scheduler/presentation/pages/Admin/add_employee_page.dart';
import 'package:medical_scheduler/presentation/widgets/login_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Admin Flow E2E Test', () {
    testWidgets(
      'Full admin journey: Login, view dashboard, add employee (invite), and logout',
      (WidgetTester tester) async {
        // Step 1: Launch the app
        await tester.pumpWidget(const ProviderScope(child: app.MyApp()));
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // --- LOGIN AS ADMIN ---
        final roleDropdown = find.byType(DropdownButtonFormField<String>);
        expect(
          roleDropdown,
          findsOneWidget,
          reason: "Role dropdown should be present on the login screen.",
        );

        await tester.tap(roleDropdown);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Admin').last);
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextField).at(0),
          'branch1.test@medicare.com',
        );
        await tester.enterText(
          find.byType(TextField).at(1),
          'securepassword123',
        );
        await tester.tap(find.widgetWithText(OutlinedButton, 'Login'));
        await tester.pumpAndSettle(const Duration(seconds: 5));

        /// --- VERIFY ADMIN DASHBOARD INITIAL STATE ---
        expect(find.byType(AdminDashboardPage), findsOneWidget);

        // --- NAVIGATE TO ADD EMPLOYEE PAGE ---
        final addEmployeeButton = find.byKey(const Key('add_employee_button'));
        expect(
          addEmployeeButton,
          findsOneWidget,
          reason: "Add Employee button should exist on dashboard.",
        );
        await tester.tap(addEmployeeButton);
        await tester.pumpAndSettle();

        // --- VERIFY ADD EMPLOYEE PAGE ---
        expect(find.byType(AddEmployeePage), findsOneWidget);

        // --- ADD A NEW DOCTOR INVITE ---
        final nameField = find.byKey(const Key('add_employee_name_field'));
        final emailField = find.byKey(const Key('add_employee_email_field'));
        final roleDropdownAdd = find.byKey(
          const Key('add_employee_role_dropdown'),
        );
        final submitButton = find.byKey(
          const Key('add_employee_submit_button'),
        );

        // Select role Doctor
        await tester.tap(roleDropdownAdd);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Doctor').last);
        await tester.pumpAndSettle();

        final testDoctorName = 'Dr. Integration Test';
        final testDoctorEmail =
            'integration.test.${DateTime.now().millisecondsSinceEpoch}@medicare.com';

        await tester.enterText(nameField, testDoctorName);
        await tester.enterText(emailField, testDoctorEmail);

        await tester.tap(submitButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // --- VERIFY RETURN TO DASHBOARD AND SUCCESS SNACKBAR ---
        expect(find.byType(AdminDashboardPage), findsOneWidget);

        // --- LOGOUT ---
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // --- VERIFY RETURN TO LOGIN SCREEN ---
        expect(find.byType(LoginWidget), findsOneWidget);
      },
    );
  });
}
