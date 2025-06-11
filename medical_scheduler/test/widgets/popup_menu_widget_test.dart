// test/widgets/popup_menu_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Make sure this path is correct
import 'package:medical_scheduler/presentation/widgets/popup_menu.dart';
import 'popup_menu_widget_test.mocks.dart';

@GenerateMocks([GoRouter])
void main() {
  late MockGoRouter mockGoRouter;

  Future<void> pumpPopupMenuWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: const Scaffold(
            body: PopupMenu(),
          ),
        ),
      ),
    );
  }

  setUp(() {
    mockGoRouter = MockGoRouter();
    // Stub the go() method for all tests
    when(mockGoRouter.go(any)).thenReturn(null);
  });

  group('PopupMenu Widget Tests', () {
    testWidgets('renders the CircleAvatar initially', (WidgetTester tester) async {
      await pumpPopupMenuWidget(tester);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    // THIS TEST SHOULD NOW PASS
    testWidgets('displays menu items when the popup button is tapped', (WidgetTester tester) async {
      await pumpPopupMenuWidget(tester);

      expect(find.text('View Profile'), findsNothing);

      // Tap the button (the CircleAvatar is the button's child now)
      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle(); // Wait for menu to appear

      // Now the items should be visible
      expect(find.text('View Profile'), findsOneWidget);
      expect(find.text('Edit Profile'), findsOneWidget);
    });
    
    // NEW TEST: Verify navigation on item selection
    testWidgets('navigates to /profile when "View Profile" is tapped', (WidgetTester tester) async {
      await pumpPopupMenuWidget(tester);

      // 1. Open the menu
      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle();
      
      // 2. Tap the "View Profile" item
      await tester.tap(find.text('View Profile'));
      await tester.pumpAndSettle();

      // 3. Verify that go() was called with the correct route
      verify(mockGoRouter.go('/profile')).called(1);
    });

    // THIS TEST SHOULD NOW PASS
    testWidgets('closes the menu when a menu item is tapped', (WidgetTester tester) async {
      await pumpPopupMenuWidget(tester);

      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle();

      expect(find.text('View Profile'), findsOneWidget);

      await tester.tap(find.text('View Profile'));
      await tester.pumpAndSettle();

      // Verify the menu has closed
      expect(find.text('View Profile'), findsNothing);
    });
  });
}