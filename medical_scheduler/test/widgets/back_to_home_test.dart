import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@GenerateMocks([GoRouter])
import 'back_to_home_test.mocks.dart';

void main() {
  late MockGoRouter mockGoRouter;

  setUp(() {
    mockGoRouter = MockGoRouter();
  });
  Widget buildTestWidget({required int roleId}) {
    return MaterialApp(
      home: Builder(
        builder: (context) => BackToHome(roleId: roleId),
      ),
    ).wrapWithGoRouter(mockGoRouter); 
  }

  testWidgets('BackToHome displays correct text and style', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget(roleId: 4));

    expect(find.text('Back To Home'), findsOneWidget);

    final textWidget = tester.widget<Text>(find.text('Back To Home'));
    expect(textWidget.style?.color, Colors.white);
    expect(textWidget.style?.fontSize, 18);

    final outlinedButton = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(outlinedButton.style?.backgroundColor?.resolve({}), const Color.fromARGB(255, 108, 117, 125));
    expect(outlinedButton.style?.shape?.resolve({}), isA<RoundedRectangleBorder>());
  });

  group('Navigation based on roleId', () {
    testWidgets('Navigates to /doctor_queue when roleId is 4', (WidgetTester tester) async {
    
      await tester.pumpWidget(buildTestWidget(roleId: 4));

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      verify(mockGoRouter.go('/doctor_queue')).called(1);
    });

    testWidgets('Navigates to /receptionist_home when roleId is 5', (WidgetTester tester) async {
      
      await tester.pumpWidget(buildTestWidget(roleId: 5));

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      verify(mockGoRouter.go('/receptionist_home')).called(1);
    });

    testWidgets('Navigates to /admin_home when roleId is 2', (WidgetTester tester) async {
      
      await tester.pumpWidget(buildTestWidget(roleId: 2));

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      verify(mockGoRouter.go('/admin_home')).called(1);
    });

    testWidgets('Navigates to /auth for unknown roleId', (WidgetTester tester) async {
      
      await tester.pumpWidget(buildTestWidget(roleId: 0));

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      verify(mockGoRouter.go('/auth')).called(1);
    });
  });
}

extension GoRouterMock on Widget {
  Widget wrapWithGoRouter(GoRouter goRouter) {
    return InheritedGoRouter(
      goRouter: goRouter,
      child: this,
    );
  }
}