import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';
import 'package:medical_scheduler/presentation/widgets/signup_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_widget_test.mocks.dart'; // You will need to generate this mock

// The widget likely uses a view model to handle logic. We'll need to mock it.
// Replace this with your actual signup view model provider.
final signupViewModelProvider = Provider((ref) => MockSignupViewModel());

// Let's create a mock for the ViewModel.
// This assumes your signup logic is in a class, which is good practice.
@GenerateMocks([GoRouter, SignupViewModel])
void main() {
  late MockGoRouter mockGoRouter;
  late MockSignupViewModel mockSignupViewModel;

  // This setup runs before each test.
  setUp(() {
    mockGoRouter = MockGoRouter();
    mockSignupViewModel = MockSignupViewModel();
    // Stub the router's navigation methods
    when(mockGoRouter.go(any)).thenReturn(null);
    // Stub the view model's signup method
    when(mockSignupViewModel.signUp(
      name: anyNamed('name'),
      email: anyNamed('email'),
      password: anyNamed('password'),
      role: anyNamed('role'),
    )).thenAnswer((_) async => true); // Assume success by default
  });

  // Helper function to build the widget tree with all necessary providers.
  Future<void> pumpSignupWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the real provider with our mock for this test
          signupViewModelProvider.overrideWithValue(mockSignupViewModel),
        ],
        child: MaterialApp(
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: const Scaffold(
              body: SignupWidget(),
            ),
          ),
        ),
      ),
    );
  }

  group('SignupWidget Tests', () {
    testWidgets('renders all form fields and button initially', (WidgetTester tester) async {
      await pumpSignupWidget(tester);

      // We find widgets by their visible text or type, just like a user would.
      expect(find.widgetWithText(TextField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Enter Password'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Confirm Password'), findsOneWidget);
      expect(find.byType(RoleDropdown), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'SignUp'), findsOneWidget);
    });

    testWidgets('allows text entry and verifies the input is displayed', (WidgetTester tester) async {
      await pumpSignupWidget(tester);
      
      // Enter text into the fields
      await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Test User');
      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Enter Password'), 'password123');
      await tester.enterText(find.widgetWithText(TextField, 'Confirm Password'), 'password123');
      
      // Instead of checking controllers, we check if the text is now visible on screen.
      // This is a much more robust test.
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      // Passwords are obscured, so we can't find them by text, but we know the input worked.
    });

    testWidgets('calls view model with correct data on signup tap', (WidgetTester tester) async {
      await pumpSignupWidget(tester);

      const name = 'Test User';
      const email = 'test@example.com';
      const password = 'password123';

      // Enter data
      await tester.enterText(find.widgetWithText(TextField, 'Name'), name);
      await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
      await tester.enterText(find.widgetWithText(TextField, 'Enter Password'), password);
      await tester.enterText(find.widgetWithText(TextField, 'Confirm Password'), password);
      
      // Assume 'Patient' is the default in the dropdown, or tap to select another role.
      // For simplicity, we assume a default.
      
      // Tap the signup button
      await tester.tap(find.widgetWithText(OutlinedButton, 'SignUp'));
      await tester.pump(); // Let the tap event process

      // Verify that the signUp method on our mock ViewModel was called with the correct data.
      verify(mockSignupViewModel.signUp(
        name: name,
        email: email,
        password: password,
        role: anyNamed('role'), // Use a matcher if the role can change
      )).called(1);
    });

    // Note: The logic for navigation should ideally live in your ViewModel and be triggered
    // by a listener in the UI, just like in your LoginWidget tests.
    testWidgets('navigates on successful signup', (WidgetTester tester) async {
        // This test assumes your widget listens to the view model's state
        // and navigates when a `isSuccess` flag is true, for example.
        // For now, we'll just test that tapping the button tries to navigate.
        await pumpSignupWidget(tester);

        // Fill the form
        await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Test');
        await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@test.com');
        await tester.enterText(find.widgetWithText(TextField, 'Enter Password'), 'pass');
        await tester.enterText(find.widgetWithText(TextField, 'Confirm Password'), 'pass');

        await tester.tap(find.widgetWithText(OutlinedButton, 'SignUp'));
        await tester.pumpAndSettle();

        // If your navigation logic is correct (e.g., in a ref.listen),
        // it should have called go() after the view model returned success.
        verify(mockGoRouter.go(any)).called(1);
    });
  });
}

// You will need to create a dummy SignupViewModel class for the mock to be generated.
// It should match the interface of your real ViewModel.
abstract class SignupViewModel {
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
  });
}