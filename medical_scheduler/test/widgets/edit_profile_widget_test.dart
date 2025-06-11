import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/presentation/widgets/edit_profile_widget.dart';

void main() {
  Widget buildTestWidget() {
    return MaterialApp(
      home: Scaffold(
        body: EditProfileWidget(),
      ),
    );
  }

  testWidgets('EditProfileWidget displays correct UI elements and styles', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(buildTestWidget());

    // Verify Column
    final columnFinder = find.byType(Column);
    expect(columnFinder, findsOneWidget, reason: 'Expected one Column');
    final column = tester.widget<Column>(columnFinder);
    expect(column.crossAxisAlignment, CrossAxisAlignment.start);

    // Debug: Log all Padding widgets
    final allPaddingFinders = find.byType(Padding);
    debugPrint('Padding widgets found: ${tester.widgetList(allPaddingFinders).map((w) => w.toString()).join('\n')}');

    // Verify TextField Padding widgets
    final textFieldPaddingFinders = find.byWidgetPredicate(
      (widget) => widget is Padding && widget.padding == const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    );
    expect(textFieldPaddingFinders, findsNWidgets(5), reason: 'Expected five Padding widgets for TextFields with EdgeInsets.symmetric(vertical: 0, horizontal: 15)');

    // Verify TextFields and their Padding
    final textFieldFinders = find.byType(TextField);
    expect(textFieldFinders, findsNWidgets(5), reason: 'Expected five TextFields');
    final labels = ['User Name', 'Email', 'Enter Password', 'New Password', 'Confirm Password'];
    for (var i = 0; i < 5; i++) {
      final paddingFinder = textFieldPaddingFinders.at(i);
      final textFieldFinder = find.descendant(
        of: paddingFinder,
        matching: find.byType(TextField),
      );
      final textField = tester.widget<TextField>(textFieldFinder);
      expect(textField.decoration?.labelText, labels[i], reason: 'TextField $i should have label ${labels[i]}');
    }

    // Debug: Log all SizedBox widgets
    final allSizedBoxFinders = find.byType(SizedBox);
    debugPrint('SizedBox widgets found: ${tester.widgetList(allSizedBoxFinders).map((w) => 'SizedBox(height: ${(w as SizedBox).height}, width: ${(w as SizedBox).width})').join('\n')}');

    // Verify SizedBox with height 20 within Column
    final sizedBoxFinder = find.descendant(
      of: columnFinder,
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == 20 && widget.width == null,
      ),
    );
    expect(sizedBoxFinder, findsOneWidget, reason: 'Expected one SizedBox with height 20 in Column');
    final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
    expect(sizedBox.height, 20, reason: 'SizedBox height should be 20');

    // Fallback: Verify Column's children count and structure
    expect(column.children.length, 7, reason: 'Column should have 7 children (5 Paddings, 1 SizedBox, 1 Center)');
    expect(column.children[5], isA<SizedBox>(), reason: 'Sixth child should be SizedBox');
    expect((column.children[5] as SizedBox).height, 20, reason: 'Sixth child should have height 20');

    // Verify OutlinedButton and its Center
    final buttonFinder = find.byType(OutlinedButton);
    expect(buttonFinder, findsOneWidget, reason: 'Expected one OutlinedButton');

    final centerFinder = find.ancestor(
      of: buttonFinder,
      matching: find.byType(Center),
    );
    expect(centerFinder, findsOneWidget, reason: 'Expected the OutlinedButton to be wrapped in a Center');

    final button = tester.widget<OutlinedButton>(buttonFinder);
    expect(button.style?.backgroundColor?.resolve({}), const Color.fromARGB(255, 39, 81, 195));
    expect(button.style?.shape?.resolve({}), isA<RoundedRectangleBorder>());
    final border = button.style?.shape?.resolve({}) as RoundedRectangleBorder?;
    expect(border?.borderRadius, BorderRadius.circular(10));

    // Verify button text
    final buttonTextFinder = find.descendant(
      of: buttonFinder,
      matching: find.text('Update'),
    );
    expect(buttonTextFinder, findsOneWidget, reason: 'Expected Update text in button');
    final buttonText = tester.widget<Text>(buttonTextFinder);
    expect(buttonText.style?.fontSize, 20);
    expect(buttonText.style?.color, Colors.white);

    // Verify OutlinedButton's internal Padding
    final buttonPaddingFinder = find.descendant(
      of: buttonFinder,
      matching: find.byType(Padding),
    );
    expect(buttonPaddingFinder, findsOneWidget, reason: 'Expected one Padding inside OutlinedButton');
    final buttonPadding = tester.widget<Padding>(buttonPaddingFinder);
    expect(buttonPadding.padding, const EdgeInsets.symmetric(horizontal: 24), reason: 'OutlinedButton should have default padding');

    // Simulate button tap
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle(); // Ensure no exceptions are thrown
  });
}
