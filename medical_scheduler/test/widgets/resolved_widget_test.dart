import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/presentation/widgets/resolved_widget.dart';

void main() {
  group('Resolved Widget Tests', () {
    Future<void> pumpResolvedWidget(WidgetTester tester, {required int count}) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Resolved(resolvedCount: count),
          ),
        ),
      );
    }

    testWidgets('displays the static text "Resolved Pending"', (WidgetTester tester) async {
      await pumpResolvedWidget(tester, count: 99);
      expect(find.text('Resolved Pending'), findsOneWidget);
    });

    testWidgets('displays the correct resolvedCount when it is a positive number', (WidgetTester tester) async {
      const testCount = 42;
      await pumpResolvedWidget(tester, count: testCount);
      expect(find.text('$testCount'), findsOneWidget);
    });

    testWidgets('displays the correct resolvedCount when it is zero', (WidgetTester tester) async {
      const testCount = 0;
      await pumpResolvedWidget(tester, count: testCount);
      expect(find.text('$testCount'), findsOneWidget);
    });

    testWidgets('has the correct container styling', (WidgetTester tester) async {
      await pumpResolvedWidget(tester, count: 1);
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
      final container = tester.widget<Container>(containerFinder);
      final boxDecoration = container.decoration as BoxDecoration;
      expect(boxDecoration.color, const Color.fromARGB(255, 43, 95, 145));
      expect(boxDecoration.borderRadius, BorderRadius.circular(20));
    });

    // THIS IS THE CORRECTED TEST
    testWidgets('displays text with the correct font size', (WidgetTester tester) async {
      await pumpResolvedWidget(tester, count: 10);

      final titleText = tester.widget<Text>(find.text('Resolved Pending'));
      final countText = tester.widget<Text>(find.text('10'));

      // The test now correctly expects the new font size of 24.
      expect(titleText.style?.fontSize, 24);
      expect(countText.style?.fontSize, 24);
    });
  });
}