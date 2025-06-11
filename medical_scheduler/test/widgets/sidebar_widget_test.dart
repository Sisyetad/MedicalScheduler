import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/core/constants/themeConstants.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/notifiers.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Auth/auth_view_model.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'back_to_home_test.mocks.dart';
import 'sidebar_widget_test.mocks.dart' hide MockGoRouter;

// Generate mocks for the dependencies
@GenerateMocks([GoRouter, AuthViewModel])
void main() {
  // Declare mocks and keys needed for tests
  late MockGoRouter mockGoRouter;
  late MockAuthViewModel mockAuthViewModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Use setUpAll to mock SharedPreferences once for all tests in this file.
  setUpAll(() {
    // This provides a mock implementation of SharedPreferences for the tests.
    SharedPreferences.setMockInitialValues({});
  });

  // Use setUp to reset mocks and notifiers before each test for isolation.
  setUp(() {
    mockGoRouter = MockGoRouter();
    mockAuthViewModel = MockAuthViewModel();

    // Reset the theme notifier before each test
    isDarkModeNotifier.value = false;

    // Stub the methods that will be called
    when(mockGoRouter.go(any)).thenReturn(null);
    when(mockAuthViewModel.onEvent(any)).thenReturn(null);
  });

  // Helper function to build the widget tree with all necessary providers.
  Future<void> pumpSideBar(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the real provider with our mock
          authViewModelProvider.overrideWith((ref) => mockAuthViewModel),
        ],
        child: MaterialApp(
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: Scaffold(
              key: scaffoldKey,
              drawer: const SideBar(),
            ),
          ),
        ),
      ),
    );

    // Open the drawer to make the SideBar visible for testing
    scaffoldKey.currentState?.openDrawer();
    // pumpAndSettle waits for the drawer animation to complete
    await tester.pumpAndSettle();
  }

  group('SideBar Widget Tests', () {
    testWidgets('renders initial widgets correctly', (WidgetTester tester) async {
      await pumpSideBar(tester);

      expect(find.text('Medicare'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsOneWidget); // Starts in light mode
    });

    testWidgets('navigates to /profile when Profile tile is tapped', (WidgetTester tester) async {
      await pumpSideBar(tester);

      // Find and tap the "Profile" list tile
      await tester.tap(find.widgetWithText(ListTile, 'Profile'));
      await tester.pumpAndSettle();

      // Verify navigation was called
      verify(mockGoRouter.go('/profile')).called(1);
      // Verify the drawer is closed after tapping
      expect(find.text('Profile'), findsNothing);
    });

    testWidgets('calls logout event and navigates when Logout tile is tapped', (WidgetTester tester) async {
      await pumpSideBar(tester);

      // Find and tap the "Logout" list tile
      await tester.tap(find.widgetWithText(ListTile, 'Logout'));
      await tester.pumpAndSettle();

      // Verify the onEvent method was called with a Logout event
      verify(mockAuthViewModel.onEvent(any)).called(1);
      // Verify navigation to the auth screen occurred
      verify(mockGoRouter.go('/auth')).called(1);
    });

    testWidgets('toggles theme from light to dark and saves to SharedPreferences', (WidgetTester tester) async {
      // Ensure we start in light mode
      isDarkModeNotifier.value = false;
      await pumpSideBar(tester);

      // 1. Initial state check
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);

      // 2. Tap the theme toggle icon button
      await tester.tap(find.byIcon(Icons.dark_mode));
      await tester.pumpAndSettle(); // Allow ValueListenableBuilder to rebuild

      // 3. Verify UI changed
      expect(find.byIcon(Icons.dark_mode), findsNothing);
      expect(find.byIcon(Icons.light_mode), findsOneWidget);

      // 4. Verify the value was saved to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(Kconstants.themeModeKey), isTrue);
    });

    testWidgets('toggles theme from dark to light and saves to SharedPreferences', (WidgetTester tester) async {
      // Start in dark mode
      isDarkModeNotifier.value = true;
      await pumpSideBar(tester);

      // 1. Initial state check
      expect(find.byIcon(Icons.light_mode), findsOneWidget);

      // 2. Tap the theme toggle icon button
      await tester.tap(find.byIcon(Icons.light_mode));
      await tester.pumpAndSettle();

      // 3. Verify UI changed
      expect(find.byIcon(Icons.light_mode), findsNothing);
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);

      // 4. Verify the value was saved to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(Kconstants.themeModeKey), isFalse);
    });
  });
}