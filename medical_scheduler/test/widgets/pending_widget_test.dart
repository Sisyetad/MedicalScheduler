import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/presentation/widgets/pending_widget.dart';

void main() {
  // Group tests for the Pending widget for better organization
  group('Pending Widget Tests', () {

    // Helper function to pump the widget within a MaterialApp
    // This is necessary to provide context like text direction and styling
    Future<void> pumpPendingWidget(WidgetTester tester, {required int count}) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pending(pendingCount: count),
          ),
        ),
      );
    }

    testWidgets('displays the static text "Pending"', (WidgetTester tester) async {
      // 1. Pump the widget with any count
      await pumpPendingWidget(tester, count: 5);

      // 2. Verify the static text "Pending" is found
      expect(find.text('Pending'), findsOneWidget);
    });

    testWidgets('displays the correct pendingCount when it is a positive number', (WidgetTester tester) async {
      const testCount = 12;

      // 1. Pump the widget with a specific count
      await pumpPendingWidget(tester, count: testCount);

      // 2. Verify the number is displayed as a string
      expect(find.text('$testCount'), findsOneWidget);
    });

    testWidgets('displays the correct pendingCount when it is zero', (WidgetTester tester) async {
      const testCount = 0;

      // 1. Pump the widget with a count of 0
      await pumpPendingWidget(tester, count: testCount);
      
      // 2. Verify the number 0 is displayed
      expect(find.text('$testCount'), findsOneWidget);
    });

    testWidgets('has the correct container styling', (WidgetTester tester) async {
      // 1. Pump the widget
      await pumpPendingWidget(tester, count: 1);

      // 2. Find the Container widget
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      // 3. Get the Container widget instance to inspect its properties
      final container = tester.widget<Container>(containerFinder);

      // 4. Assert that the decoration is a BoxDecoration
      expect(container.decoration, isA<BoxDecoration>());

      // 5. Cast the decoration to BoxDecoration to check its properties
      final boxDecoration = container.decoration as BoxDecoration;

      // 6. Verify the color and border radius
      expect(boxDecoration.color, const Color.fromARGB(255, 43, 95, 145));
      expect(boxDecoration.borderRadius, BorderRadius.circular(20));
    });

    testWidgets('displays both text widgets correctly', (WidgetTester tester) async {
      // A combined test to ensure both pieces of text are present
      const testCount = 99;
      await pumpPendingWidget(tester, count: testCount);

      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('$testCount'), findsOneWidget);
    });
  });
}