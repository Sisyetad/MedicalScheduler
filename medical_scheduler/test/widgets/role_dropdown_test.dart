import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';

void main() {
  // Helper function to build the widget
  Widget buildTestWidget() {
    return MaterialApp(
      home: Scaffold(
        body: RoleDropdown(),
      ),
    );
  }

  testWidgets('RoleDropdown displays correct UI and handles role selection', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(buildTestWidget());

    // Verify DropdownButtonFormField exists
    final dropdownFinder = find.byType(DropdownButtonFormField<String>);
    expect(dropdownFinder, findsOneWidget, reason: 'Expected one DropdownButtonFormField');

    // Verify initial placeholder is shown
    expect(find.text('Select Role'), findsOneWidget);
    expect(find.text('Doctor'), findsNothing);
    expect(find.text('Receptionist'), findsNothing);
    expect(find.text('Admin'), findsNothing);

    // Open the dropdown
    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle(); // Wait for dropdown to open

    // Verify dropdown menu items
    expect(find.text('Select Role'), findsNWidgets(2)); // One in field, one in menu
    expect(find.text('Doctor'), findsOneWidget);
    expect(find.text('Receptionist'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);

    // Select "Doctor"
    await tester.tap(find.text('Doctor'));
    await tester.pumpAndSettle();

    // Confirm that "Doctor" is now selected
    expect(find.text('Doctor'), findsOneWidget, reason: 'Doctor should now be the selected role');
    expect(find.text('Select Role'), findsNothing, reason: 'Placeholder should be gone after selection');
  });
}
