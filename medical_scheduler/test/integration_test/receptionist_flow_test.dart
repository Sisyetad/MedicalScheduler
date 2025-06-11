import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medical_scheduler/main.dart' as app;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/pages/Receptionist/receptionist_queue.dart';
import 'package:medical_scheduler/presentation/pages/Receptionist/add_patient_page.dart';
import 'package:medical_scheduler/presentation/widgets/login_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Receptionist Flow E2E Test', () {
    testWidgets(
      'Full receptionist journey: Login, view queue, add patient, and logout',
      (WidgetTester tester) async {
        // Step 1: Launch the app
        await tester.pumpWidget(const ProviderScope(child: app.MyApp()));
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // --- LOGIN AS RECEPTIONIST ---
        final roleDropdown = find.byType(DropdownButtonFormField<String>);
        expect(
          roleDropdown,
          findsOneWidget,
          reason: "Role dropdown should be present on the login screen.",
        );

        await tester.tap(roleDropdown);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Receptionist').last);
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextField).at(0),
          'nat@medicare.com',
        );
        await tester.enterText(
          find.byType(TextField).at(1),
          'securepassword123',
        );
        await tester.tap(find.widgetWithText(OutlinedButton, 'Login'));
        await tester.pumpAndSettle(const Duration(seconds: 5));

        // --- VERIFY RECEPTIONIST QUEUE PAGE ---
        expect(find.byType(ReceptionistQueuePage), findsOneWidget);

        // --- NAVIGATE TO ADD PATIENT PAGE ---
        final addPatientButton = find.byKey(const Key('queue_add_patient_button'));
        expect(
          addPatientButton,
          findsOneWidget,
          reason: "Add Patient button should exist on queue page.",
        );
        await tester.tap(addPatientButton);
        await tester.pumpAndSettle();

        // --- VERIFY ADD PATIENT PAGE ---
        expect(find.byType(AddPatientPage), findsOneWidget);

        // --- FILL PATIENT FORM ---
        final fullNameField = find.byKey(const Key('add_patient_full_name_field'));
        final dobField = find.byKey(const Key('add_patient_dob_field'));
        final emailField = find.byKey(const Key('add_patient_email_field'));
        final addressField = find.byKey(const Key('add_patient_address_field'));
        final phoneField = find.byKey(const Key('add_patient_phone_field'));
        final genderDropdown = find.byKey(const Key('add_patient_gender_dropdown'));
        final submitButton = find.byKey(const Key('add_patient_submit_button'));

        // Fill in the form
        await tester.enterText(fullNameField, 'Test Patient');
        await tester.tap(dobField);
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
        await tester.enterText(emailField, 'test.patient@example.com');
        await tester.enterText(addressField, '123 Test Street');
        await tester.enterText(phoneField, '+1234567890');

        // Select gender
        await tester.ensureVisible(genderDropdown);
        await tester.tap(genderDropdown);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Male').first);
        await tester.pumpAndSettle();

        // Submit the form
        await tester.tap(submitButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // --- VERIFY RETURN TO QUEUE PAGE ---
        expect(find.byType(ReceptionistQueuePage), findsOneWidget);

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