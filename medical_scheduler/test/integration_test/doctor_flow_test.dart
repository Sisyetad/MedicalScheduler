import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medical_scheduler/main.dart' as app;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/doctor_queue_page.dart';
import 'package:medical_scheduler/presentation/pages/Doctor/patient_history_page.dart';
import 'package:medical_scheduler/presentation/widgets/login_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Doctor Flow E2E Test', () {
    testWidgets(
      'Full doctor journey: Login, view queue, view patient history, view diagnosis details, add diagnosis, and logout',
      (WidgetTester tester) async {
        // Step 1: Launch the app
        await tester.pumpWidget(const ProviderScope(child: app.MyApp()));
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // --- LOGIN AS DOCTOR ---
        final roleDropdown = find.byType(DropdownButtonFormField<String>);
        expect(
          roleDropdown,
          findsOneWidget,
          reason: "Role dropdown should be present on the login screen.",
        );

        await tester.tap(roleDropdown);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Doctor').last);
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextField).at(0),
          'doctor1@medicare.com',
        );
        await tester.enterText(
          find.byType(TextField).at(1),
          'securepassword123',
        );
        await tester.tap(find.widgetWithText(OutlinedButton, 'Login'));
        await tester.pumpAndSettle(const Duration(seconds: 5));

        // --- VERIFY DOCTOR QUEUE PAGE ---
        expect(find.byType(DoctorPage), findsOneWidget);
        expect(find.byKey(const Key('doctor_queue_title')), findsOneWidget);

        // --- CLICK VIEW HISTORY ON FIRST QUEUE ITEM ---
        final viewHistoryButton = find.byKey(const Key('doctor_queue_view_history_button'));
        expect(
          viewHistoryButton,
          findsOneWidget,
          reason: "View History button should exist on queue page.",
        );
        await tester.tap(viewHistoryButton.first);
        await tester.pumpAndSettle();

        // --- VERIFY PATIENT HISTORY PAGE ---
        expect(find.byType(PatientHistoryPage), findsOneWidget);
        expect(find.byKey(const Key('patient_history_title')), findsOneWidget);

        // --- CLICK VIEW DETAILS ON FIRST DIAGNOSIS ---
        final viewDetailsButton = find.byKey(const Key('patient_history_view_details_button'));
        expect(
          viewDetailsButton,
          findsOneWidget,
          reason: "View Details button should exist on patient history page.",
        );
        await tester.tap(viewDetailsButton.first);
        await tester.pumpAndSettle();

        // --- VERIFY DIAGNOSIS DETAILS PAGE ---
        expect(find.byKey(const Key('diagnosis_details_title')), findsOneWidget);

        // Wait for 3 seconds
        await Future.delayed(const Duration(seconds: 3));

        // --- CLICK BACK BUTTON ---
        final backButton = find.byKey(const Key('diagnosis_details_back_button'));
        expect(
          backButton,
          findsOneWidget,
          reason: "Back button should exist on diagnosis details page.",
        );
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // --- VERIFY RETURN TO PATIENT HISTORY PAGE ---
        expect(find.byType(PatientHistoryPage), findsOneWidget);

        // --- CLICK ADD DIAGNOSIS BUTTON ---
        final addDiagnosisButton = find.byKey(const Key('patient_history_add_diagnosis_button'));
        expect(
          addDiagnosisButton,
          findsOneWidget,
          reason: "Add Diagnosis button should exist on patient history page.",
        );
        await tester.tap(addDiagnosisButton);
        await tester.pumpAndSettle();

        // --- VERIFY ADD DIAGNOSIS PAGE ---
        expect(find.byKey(const Key('add_diagnosis_title')), findsOneWidget);

        // --- FILL DIAGNOSIS FORM ---
        final symptomsField = find.byKey(const Key('add_diagnosis_symptoms_field'));
        final diagnosisField = find.byKey(const Key('add_diagnosis_diagnosis_field'));
        final prescriptionField = find.byKey(const Key('add_diagnosis_prescription_field'));
        final submitButton = find.byKey(const Key('add_diagnosis_submit_button'));

        await tester.enterText(symptomsField, 'Fever, cough, fatigue');
        await tester.enterText(diagnosisField, 'Common cold');
        await tester.enterText(prescriptionField, 'Rest, fluids, over-the-counter cold medicine');

        await tester.tap(submitButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // --- VERIFY RETURN TO PATIENT HISTORY PAGE ---
        expect(find.byType(PatientHistoryPage), findsOneWidget);

        // --- CLICK BACK BUTTON ---
        final patientHistoryBackButton = find.byKey(const Key('patient_history_back_button'));
        expect(
          patientHistoryBackButton,
          findsOneWidget,
          reason: "Back button should exist on patient history page.",
        );
        await tester.tap(patientHistoryBackButton);
        await tester.pumpAndSettle();

        // --- VERIFY RETURN TO DOCTOR QUEUE PAGE ---
        expect(find.byType(DoctorPage), findsOneWidget);

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