import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Doctor/doctor_queue_view_model.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/queue_provider.dart';
import 'package:medical_scheduler/presentation/events/Doctor/doctor_queue_events.dart';
import 'package:medical_scheduler/presentation/widgets/doctor_queue_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks
@GenerateMocks([GoRouter, DoctorQueueNotifier, ProviderRef])
import 'doctor_queue_widget_test.mocks.dart';

void main() {
  // Test Patients
  final testPatientJohn = Patient(
    patientId: 101,
    username: 'john123',
    email: 'john@example.com',
    role: Role(roleId: 1, name: 'patient'),
    createdAt: '2024-01-01T00:00:00Z',
    updatedAt: '2024-01-01T00:00:00Z',
    firstName: 'John',
    lastName: 'Doe',
    address: '123 Street',
    phoneNumber: '1234567890',
    gender: 'Male',
    dateOfBirth: '1990-01-01',
  );

  final testPatientJane = Patient(
    patientId: 102,
    username: 'jane456',
    email: 'jane@example.com',
    role: Role(roleId: 1, name: 'patient'),
    createdAt: '2024-01-01T00:00:00Z',
    updatedAt: '2024-01-01T00:00:00Z',
    firstName: 'Jane',
    lastName: 'Smith',
    address: '456 Avenue',
    phoneNumber: '9876543210',
    gender: 'Female',
    dateOfBirth: '1992-02-02',
  );

  final testQueues = [
    DataQueue(
      queueId: 1,
      patient: testPatientJohn,
      status: 1,
      createdAt: '2025-06-01T10:00:00Z',
    ),
    DataQueue(
      queueId: 2,
      patient: testPatientJane,
      status: 2,
      createdAt: '2025-06-01T10:05:00Z',
    ),
  ];

  // Widget wrapper
  Widget buildTestWidget({
    required List<DataQueue> queues,
    required MockGoRouter mockGoRouter,
    required MockDoctorQueueNotifier mockNotifier,
  }) {
    return ProviderScope(
      overrides: [
        doctorQueueNotifierProvider.overrideWith((ref) => mockNotifier),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) => DoctorQueueWidget(queues: queues),
        ),
      ).wrapWithGoRouter(mockGoRouter),
    );
  }

  testWidgets('DoctorQueueWidget displays correct table and handles actions', (WidgetTester tester) async {
    // Initialize mocks
    final mockGoRouter = MockGoRouter();
    final mockNotifier = MockDoctorQueueNotifier();

    // Setup mock behavior
    when(mockNotifier.mapEventToState(any)).thenAnswer((_) async {});

    // Build the widget
    await tester.pumpWidget(buildTestWidget(
      queues: testQueues,
      mockGoRouter: mockGoRouter,
      mockNotifier: mockNotifier,
    ));

    // Pump to settle Riverpod
    await tester.pumpAndSettle();

    // Check DataTable and column headers
    final dataTableFinder = find.byType(DataTable);
    expect(dataTableFinder, findsOneWidget, reason: 'Expected one DataTable');
    final dataTable = tester.widget<DataTable>(dataTableFinder);
    expect(dataTable.headingRowHeight, 40);
    expect(dataTable.dataRowHeight, 120);
    expect(dataTable.border, TableBorder.all(color: Colors.grey, width: 1));

    // Verify column headers
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Actions'), findsOneWidget);
    final headerText = tester.widget<Text>(find.text('Name'));
    expect(headerText.style?.color, Colors.white);

    // Verify heading row color
    expect(
      dataTable.headingRowColor?.resolve({}),
      const Color.fromARGB(255, 43, 95, 145),
    );

    // Verify rows
    expect(dataTable.rows.length, 2);
    expect(find.text('John'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('Resolve'), findsOneWidget);
    expect(find.text('View History'), findsNWidgets(2));
    expect(find.text('Complete'), findsNWidgets(2));
    expect(find.text('Jane'), findsOneWidget);
    expect(find.text('Resolved'), findsOneWidget);
    expect(find.text('Pend'), findsOneWidget);

    // Verify button styles (Resolve button)
    final resolveButtonFinder = find.widgetWithText(ElevatedButton, 'Resolve');
    expect(resolveButtonFinder, findsOneWidget, reason: 'Expected one Resolve button');
    final resolveButton = tester.widget<ElevatedButton>(resolveButtonFinder);
    expect(resolveButton.style?.backgroundColor?.resolve({}), const Color(0xFF2B5F91));
    expect(resolveButton.style?.textStyle?.resolve({})?.fontSize, 12);

    // Debug: Capture mapEventToState calls
    final capturedEvents = <DoctorQueueEvent>[];
    when(mockNotifier.mapEventToState(any)).thenAnswer((invocation) async {
      capturedEvents.add(invocation.positionalArguments[0] as DoctorQueueEvent);
    });

    // Test Resolve button
    await tester.tap(resolveButtonFinder);
    await tester.pumpAndSettle(); // Handle async Riverpod updates
    print('Captured events: $capturedEvents'); // Debug output
    verify(mockNotifier.mapEventToState(any)).called(1);
    expect(
      capturedEvents.any((event) =>
          event is UpdateQueueStatus &&
          event.queueId == 1 &&
          event.status == 2),
      isTrue,
      reason: 'Expected UpdateQueueStatus(1, 2)',
    );

    // Test View History button (first row)
    final viewHistoryButtonFinder = find.widgetWithText(ElevatedButton, 'View History').first;
    await tester.tap(viewHistoryButtonFinder);
    await tester.pumpAndSettle();
    verify(mockGoRouter.go('/patient_history/101')).called(1);

    // Test Complete button (first row)
    final completeButtonFinder = find.widgetWithText(ElevatedButton, 'Complete').first;
    await tester.tap(completeButtonFinder);
    await tester.pumpAndSettle();
    verify(mockNotifier.mapEventToState(any)).called(1);
    expect(
      capturedEvents.any((event) =>
          event is UpdateQueueStatus &&
          event.queueId == 1 &&
          event.status == 3),
      isTrue,
      reason: 'Expected UpdateQueueStatus(1, 3)',
    );
  });
}

// Extension for mocking GoRouter
extension GoRouterMock on Widget {
  Widget wrapWithGoRouter(GoRouter goRouter) {
    return InheritedGoRouter(
      goRouter: goRouter,
      child: this,
    );
  }
}