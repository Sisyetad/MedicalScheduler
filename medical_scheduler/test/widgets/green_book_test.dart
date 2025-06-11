
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/presentation/widgets/card_widget.dart'; // Contains GreenBook

void main() {
  // Create a test DiagnosisHistory instance
  final testDiagnosis = DiagnosisHistory(
    diagnosisId: 1,
    diagnosisName: 'Flu',
    createdTime: '2025-06-10',
    doctor: Doctor(
      doctorId: 1,
      username: 'dr_smith',
      email: 'dr.smith@example.com',
      role: Role(roleId: 4, name: 'doctor'),
      createdAt: '2024-01-01T00:00:00Z',
      updatedAt: '2024-01-01T00:00:00Z',
    ),
    medication: 'Paracetamol',
    comment: 'Rest for 3 days',
    patient: Patient(
      patientId: 1,
      username: 'john_doe',
      email: 'john.doe@example.com',
      role: Role(roleId: 5, name: 'patient'),
      createdAt: '2024-01-01T00:00:00Z',
      updatedAt: '2024-01-01T00:00:00Z',
      firstName: 'John',
      lastName: 'Doe',
      address: '123 Main St',
      phoneNumber: '1234567890',
      gender: 'Male',
      dateOfBirth: '1993-06-10',
    ),
  );

  // Helper function to build the widget
  Widget buildTestWidget() {
    return MaterialApp(
      home: Scaffold(
        body: GreenBook(diagnosis: testDiagnosis),
      ),
    );
  }

  testWidgets('GreenBook displays correct diagnosis details and styles', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(buildTestWidget());

    // Debug: Print widget tree to identify extra Padding
    final greenBookFinder = find.byType(GreenBook);
    expect(greenBookFinder, findsOneWidget, reason: 'Expected one GreenBook widget');

    // Debug: Log all Containers in GreenBook subtree
    final containerFinders = find.descendant(
      of: greenBookFinder,
      matching: find.byType(Container),
    );
    debugPrint('Containers found: ${tester.widgetList(containerFinders).map((w) => w.toString()).join('\n')}');

    // Debug: Log all Paddings in GreenBook subtree
    final allPaddingFinders = find.descendant(
      of: greenBookFinder,
      matching: find.byType(Padding),
    );
    debugPrint('Paddings found: ${tester.widgetList(allPaddingFinders).map((w) => w.toString()).join('\n')}');

    // Find the Container inside GreenBook
    final containerFinder = find.descendant(
      of: greenBookFinder,
      matching: find.byType(Container),
    );
    expect(containerFinder, findsOneWidget, reason: 'Expected one Container inside GreenBook');
    final container = tester.widget<Container>(containerFinder);
    expect(container.constraints?.maxWidth, 323);
    expect(container.constraints?.maxHeight, 426);
    expect(container.decoration, isA<BoxDecoration>());
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, const Color.fromARGB(255, 43, 95, 145));
    expect(boxDecoration.borderRadius, BorderRadius.circular(15));

    // Find the Padding widget with EdgeInsets.all(8.0) inside the Container
    final paddingFinder = find.descendant(
      of: containerFinder,
      matching: find.byWidgetPredicate(
        (widget) => widget is Padding && widget.padding == const EdgeInsets.all(8.0),
      ),
    );
    expect(paddingFinder, findsOneWidget, reason: 'Expected one Padding widget with EdgeInsets.all(8.0) inside GreenBook\'s Container');
    final padding = tester.widget<Padding>(paddingFinder);
    expect(padding.padding, const EdgeInsets.all(8.0), reason: 'Padding should be EdgeInsets.all(8.0)');

    // Find the Column inside the Padding
    final columnFinder = find.descendant(
      of: paddingFinder,
      matching: find.byType(Column),
    );
    expect(columnFinder, findsOneWidget, reason: 'Expected one Column inside Padding');
    final column = tester.widget<Column>(columnFinder);
    expect(column.crossAxisAlignment, CrossAxisAlignment.start);

    // Verify text content
    expect(find.text('Diagnosis Name: Flu'), findsOneWidget);
    expect(find.text('Date: 2025-06-10'), findsOneWidget);
    expect(find.text("Doctor's Name: dr_smith"), findsOneWidget);
    expect(find.text('Medication: Paracetamol'), findsOneWidget);
    expect(find.text('Comments: Rest for 3 days'), findsOneWidget);

    // Verify text styles
    final diagnosisText = tester.widget<Text>(find.text('Diagnosis Name: Flu'));
    expect(diagnosisText.style?.color, Colors.white);
    expect(diagnosisText.style?.fontSize, 17);

    final dateText = tester.widget<Text>(find.text('Date: 2025-06-10'));
    expect(dateText.style?.color, Colors.white);
    expect(dateText.style?.fontSize, 15);

    final doctorText = tester.widget<Text>(find.text("Doctor's Name: dr_smith"));
    expect(doctorText.style?.color, Colors.white);
    expect(doctorText.style?.fontSize, 15);

    final medicationText = tester.widget<Text>(find.text('Medication: Paracetamol'));
    expect(medicationText.style?.color, Colors.white);
    expect(medicationText.style?.fontSize, 15);

    final commentText = tester.widget<Text>(find.text('Comments: Rest for 3 days'));
    expect(commentText.style?.color, Colors.white);
    expect(commentText.style?.fontSize, 15);

    // Verify SizedBox spacers
    expect(find.byType(SizedBox), findsNWidgets(4));
    final sizedBox = tester.widgetList<SizedBox>(find.byType(SizedBox)).first;
    expect(sizedBox.height, 8);
  });
}