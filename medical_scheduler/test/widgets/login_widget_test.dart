import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/Application/Usecases/auth/login.dart';
import 'package:medical_scheduler/Application/Usecases/auth/signUp.dart';
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Auth/auth_view_model.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart';
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';
import 'package:medical_scheduler/presentation/widgets/login_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_widget_test.mocks.dart';

class FakeAuthViewModel extends StateNotifier<AuthUiState> implements AuthViewModel {
  // 1. Call the super constructor with an initial state.
  FakeAuthViewModel() : super(AuthUiState());

  // 2. Keep track of the last event for verification.
  AuthEvent? lastEvent;

  // 3. Implement the onEvent method to capture the event for testing.
  @override
  void onEvent(AuthEvent event) {
    lastEvent = event;
  }

  // 4. Create a public method to manually change the state for our tests.
  void setState(AuthUiState newState) {
    state = newState;
  }

  // 5. Explicitly implement all other methods/getters from the AuthViewModel interface.
  // This is the key fix. We satisfy the interface contract without writing any logic,
  // because these specific tests don't require these methods to do anything.
  @override
  Future<void> checkLoginStatus() {
    throw UnimplementedError("checkLoginStatus was called but not implemented in FakeAuthViewModel");
  }

  @override
  Future<void> logout() {
    throw UnimplementedError("logout was called but not implemented in FakeAuthViewModel");
  }
  
  Future<void> registerUser({required String username, required String email, required String password, required String role}) {
     throw UnimplementedError("registerUser was called but not implemented in FakeAuthViewModel");
  }

  // Explicitly implement the getters required by the interface
  @override
  LoginUseCase get loginUseCase => throw UnimplementedError();

  @override
  GetUserUseCase get getUserUseCase => throw UnimplementedError();

  @override
  RegisterUseCase get registerUseCase => throw UnimplementedError();

  @override
  FlutterSecureStorage get storage => throw UnimplementedError();
}


// This is a provider used by the RoleDropdown. We need to create a dummy one here
// so we can override it in our tests. Replace with your actual provider definition.
final rolesProvider = FutureProvider<List<Role>>((ref) async {
  throw UnimplementedError();
});


@GenerateMocks([GoRouter])
void main() {
  // We no longer need to mock AuthViewModel, we use our FakeAuthViewModel.
  late FakeAuthViewModel fakeAuthViewModel;
  late MockGoRouter mockGoRouter;

  // Helper function to create a ProviderContainer with necessary overrides.
  ProviderContainer createTestContainer() {
    return ProviderContainer(
      overrides: [
        // Override the provider to return our fake view model instance.
        authViewModelProvider.overrideWith((ref) => fakeAuthViewModel),
        rolesProvider.overrideWith(
          (ref) => Future.value([
            Role(roleId: 1, name: 'Patient'),
            Role(roleId: 4, name: 'doctor'),
          ]),
        ),
      ],
    );
  }

  setUp(() {
    fakeAuthViewModel = FakeAuthViewModel();
    mockGoRouter = MockGoRouter();

    // Stub the GoRouter's go method
    when(mockGoRouter.go(any)).thenReturn(null);
  });

  // Helper to build the widget tree
  Future<void> pumpLoginWidget(WidgetTester tester, ProviderContainer container) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: const Scaffold(body: LoginWidget()),
          ),
        ),
      ),
    );
    // Pump again for the rolesProvider FutureProvider to resolve.
    await tester.pump();
  }

  testWidgets('Renders correctly in initial state', (WidgetTester tester) async {
    final container = createTestContainer();
    await pumpLoginWidget(tester, container);

    // Verify initial UI elements are present
    expect(find.byType(RoleDropdown), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Login'), findsOneWidget);
  });

  testWidgets('Calls onEvent with correct data when login button is tapped', (WidgetTester tester) async {
    final container = createTestContainer();
    await pumpLoginWidget(tester, container);

    const email = 'test@example.com';
    const password = 'password123';

    await tester.enterText(find.byKey(const Key('login_email_field')), email);
    await tester.enterText(find.byKey(const Key('login_password_field')), password);
    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();

    // Verify that the onEvent method was called with a SubmitLogin event
    final capturedEvent = fakeAuthViewModel.lastEvent;
    expect(capturedEvent, isA<SubmitLogin>());
    expect((capturedEvent as SubmitLogin).email, email);
    expect(capturedEvent.password, password);
  });

  testWidgets('Shows loading indicator when isLoading is true', (WidgetTester tester) async {
    final container = createTestContainer();

    // Set the state to loading using our new helper method
    fakeAuthViewModel.setState(AuthUiState(isLoading: true));

    await pumpLoginWidget(tester, container);

    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(button.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error message when error is present', (WidgetTester tester) async {
    final container = createTestContainer();
    const errorMessage = 'Invalid credentials';

    // Set the state to have an error
    fakeAuthViewModel.setState(AuthUiState(error: errorMessage));

    await pumpLoginWidget(tester, container);
    
    // It's common to show errors in a SnackBar. pumpAndSettle will animate it into view.
    await tester.pumpAndSettle(); 

    expect(find.text(errorMessage), findsOneWidget);
  });

  group('Navigation on successful login', () {
    testWidgets('navigates to /doctor_queue for a doctor (roleId 4)', (tester) async {
      final container = createTestContainer();
      await pumpLoginWidget(tester, container);

      final doctorUser = User(
        userId: 1,
        username: 'test_doctor',
        email: 'doctor@test.com',
        role: Role(roleId: 4, name: 'doctor'),
        createdAt: 'date',
        updatedAt: 'date',
      );

      // Change the state using our fake view model
      fakeAuthViewModel.setState(AuthUiState(user: doctorUser));

      // Pump the widget again to allow it to rebuild and react to the new state.
      // This is when the `ref.listen` in your widget will trigger the navigation.
      await tester.pump();

      // Verify that GoRouter was called to navigate.
      verify(mockGoRouter.go('/doctor_queue')).called(1);
    });

    testWidgets('navigates to /patient_dashboard for a patient (roleId 1)', (tester) async {
      final container = createTestContainer();
      await pumpLoginWidget(tester, container);

      final patientUser = User(
        userId: 2,
        username: 'test_patient',
        email: 'patient@test.com',
        role: Role(roleId: 1, name: 'Patient'),
        createdAt: 'date',
        updatedAt: 'date',
      );

      fakeAuthViewModel.setState(AuthUiState(user: patientUser));
      await tester.pump();

      verify(mockGoRouter.go('/patient_dashboard')).called(1);
    });
  });
}