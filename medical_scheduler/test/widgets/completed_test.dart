import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/presentation/widgets/completed_widget.dart';
void main() {
  // Helper function to build the widget
  Widget buildTestWidget({required int completedCount}) {
    return MaterialApp(
      home: Scaffold(
        body: Completed(completedCount: completedCount),
      ),
    );
  }

  testWidgets('Completed displays correct UI elements and styles', (WidgetTester tester) async {
    // Build the widget with completedCount = 42
    await tester.pumpWidget(buildTestWidget(completedCount: 42));

    // Verify Container properties
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsOneWidget, reason: 'Expected one Container in Completed');
    final container = tester.widget<Container>(containerFinder);
    expect(container.constraints?.maxHeight, 100);
    expect(container.constraints?.maxWidth, 308);
    expect(container.decoration, isA<BoxDecoration>());
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, const Color.fromARGB(255, 43, 95, 145));
    expect(boxDecoration.borderRadius, BorderRadius.circular(20));

    // Verify Wrap widget
    final wrapFinder = find.descendant(
      of: containerFinder,
      matching: find.byType(Wrap),
    );
    expect(wrapFinder, findsOneWidget, reason: 'Expected one Wrap inside Container');

    // Verify three Padding widgets inside Wrap
    final paddingFinders = find.descendant(
      of: wrapFinder,
      matching: find.byType(Padding),
    );
    expect(paddingFinders, findsNWidgets(3), reason: 'Expected three Padding widgets inside Wrap');

    // Verify first Padding (Icon)
    final iconPaddingFinder = paddingFinders.at(0);
    final iconPadding = tester.widget<Padding>(iconPaddingFinder);
    expect(iconPadding.padding, const EdgeInsets.all(8.0));
    final iconFinder = find.descendant(
      of: iconPaddingFinder,
      matching: find.byIcon(Icons.heart_broken),
    );
    expect(iconFinder, findsOneWidget, reason: 'Expected one Icon in first Padding');
    final icon = tester.widget<Icon>(iconFinder);
    expect(icon.size, 35);

    // Verify second Padding (Text: "Total completed")
    final textPaddingFinder = paddingFinders.at(1);
    final textPadding = tester.widget<Padding>(textPaddingFinder);
    expect(textPadding.padding, const EdgeInsets.all(8.0));
    final totalTextFinder = find.descendant(
      of: textPaddingFinder,
      matching: find.text('Total completed'),
    );
    expect(totalTextFinder, findsOneWidget, reason: 'Expected "Total completed" text in second Padding');
    final totalText = tester.widget<Text>(totalTextFinder);
    expect(totalText.style?.fontSize, 30);

    // Verify third Padding (Text: completedCount)
    final countPaddingFinder = paddingFinders.at(2);
    final countPadding = tester.widget<Padding>(countPaddingFinder);
    expect(countPadding.padding, const EdgeInsets.symmetric(horizontal: 60.0));
    final countTextFinder = find.descendant(
      of: countPaddingFinder,
      matching: find.text('42'),
    );
    expect(countTextFinder, findsOneWidget, reason: 'Expected completedCount text in third Padding');
    final countText = tester.widget<Text>(countTextFinder);
    expect(countText.style?.fontSize, 30);
  });
}