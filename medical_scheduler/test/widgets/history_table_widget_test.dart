import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/presentation/widgets/history_table_widget.dart';

void main() {
  Widget buildTestWidget({
    required List<DiagnosisHistory> diagnosisList,
    required Function(int) onViewDetails,
  }) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
        dataTableTheme: DataTableThemeData(
          // Added fontWeight to make the test more specific
          headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headingRowColor: WidgetStateProperty.all(const Color.fromARGB(255, 43, 95, 145)),
        ),
      ),
      home: Scaffold(
        body: HistoryTableWidget(
          diagnosisList: diagnosisList,
          onViewDetails: onViewDetails,
        ),
      ),
    );
  }

  // Mock data setup
  final diagnosisList = [
      DiagnosisHistory(
        diagnosisId: 1,
        diagnosisName: 'Flu',
        createdTime: '2025-06-01 10:00',
        doctor: Doctor( doctorId: 101, username: 'drsmith', email: 'smith@hospital.com', role: Role(roleId: 1, name: 'doctor'), createdAt: '2025-01-01 00:00', updatedAt: '2025-01-01 00:00', specialization: 'General Medicine', branch: Branch( branchId: 1, username: 'mainbranch', email: 'main@hospital.com', role: Role(roleId: 2, name: 'branch'), createdAt: '2025-01-01 00:00', updatedAt: '2025-01-01 00:00', location: 'Downtown', headOffice: null, ), ),
        medication: 'Antiviral',
        comment: 'Rest and hydrate',
        patient: Patient( patientId: 201, username: 'johndoe', email: 'john@patient.com', role: Role(roleId: 3, name: 'patient'), createdAt: '2025-01-01 00:00', updatedAt: '2025-01-01 00:00', firstName: 'John', lastName: 'Doe', address: '123 Main St', phoneNumber: '555-0101', gender: 'Male', dateOfBirth: '1990-01-01', ),
      ),
      DiagnosisHistory(
        diagnosisId: 2,
        diagnosisName: 'Migraine',
        createdTime: '2025-06-02 14:30',
        doctor: Doctor( doctorId: 102, username: 'drjones', email: 'jones@hospital.com', role: Role(roleId: 1, name: 'doctor'), createdAt: '2025-01-01 00:00', updatedAt: '2025-01-01 00:00', specialization: 'Neurology', branch: Branch( branchId: 2, username: 'neurobranch', email: 'neuro@hospital.com', role: Role(roleId: 2, name: 'branch'), createdAt: '2025-01-01 00:00', updatedAt: '2025-01-01 00:00', location: 'Uptown', headOffice: null, ), ),
        medication: 'Painkiller',
        comment: 'Avoid bright lights',
        patient: Patient( patientId: 202, username: 'janeroe', email: 'jane@patient.com', role: Role(roleId: 3, name: 'patient'), createdAt: '2025-01-01 00:00', updatedAt: '2025-01-01 00:00', firstName: 'Jane', lastName: 'Roe', address: '456 Elm St', phoneNumber: '555-0102', gender: 'Female', dateOfBirth: '1985-02-02', ),
      ),
    ];

  testWidgets('HistoryTableWidget displays correct table and handles actions', (WidgetTester tester) async {
    int? calledDiagnosisId;
    void mockOnViewDetails(int diagnosisId) {
      calledDiagnosisId = diagnosisId;
    }

    await tester.pumpWidget(buildTestWidget(
      diagnosisList: diagnosisList,
      onViewDetails: mockOnViewDetails,
    ));
    await tester.pumpAndSettle();

    final dataTableFinder = find.byType(DataTable);
    expect(dataTableFinder, findsOneWidget, reason: 'Expected one DataTable');
    final dataTable = tester.widget<DataTable>(dataTableFinder);
    expect(dataTable.headingRowHeight, 40);
    expect(dataTable.dataRowMinHeight, 120);
    expect(dataTable.dataRowMaxHeight, 120);
    expect(dataTable.border, TableBorder.all(color: Colors.grey, width: 1));
    expect(
      dataTable.headingRowColor?.resolve({}),
      const Color.fromARGB(255, 43, 95, 145),
      reason: 'Heading row color should be correct',
    );
    
    // Find the 'Name' header text
    final nameHeaderTextFinder = find.text('Name');
    expect(nameHeaderTextFinder, findsOneWidget, reason: 'Expected to find "Name" header text');

    // **THE FIX:** Find the *closest* DefaultTextStyle ancestor and test it directly.
    final defaultTextStyleFinder = find.ancestor(
      of: nameHeaderTextFinder,
      matching: find.byType(DefaultTextStyle),
    ).first;

    // Get the widget and check its style property directly. This is robust.
    final defaultTextStyleWidget = tester.widget<DefaultTextStyle>(defaultTextStyleFinder);
    expect(
      defaultTextStyleWidget.style.color,
      Colors.white,
      reason: 'Header text color should be white from the closest DefaultTextStyle widget'
    );
    expect(
      defaultTextStyleWidget.style.fontWeight,
      FontWeight.bold,
      reason: 'Header text font weight should be bold from the theme'
    );

    // --- Rest of the test continues as before ---
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('Actions'), findsOneWidget);

    expect(dataTable.rows.length, 2, reason: 'Expected two rows for diagnosisList');
    expect(find.text('Flu'), findsOneWidget);
    expect(find.text('2025-06-01 10:00'), findsOneWidget);
    expect(find.text('Migraine'), findsOneWidget);
    expect(find.text('2025-06-02 14:30'), findsOneWidget);
    expect(find.text('View'), findsNWidgets(2));

    final dateCellText = tester.widget<Text>(find.text('2025-06-01 10:00'));
    expect(dateCellText.style?.fontSize, 12);
    expect(dateCellText.style?.color, Colors.grey);
    final dateCellSizedBox = tester.widget<SizedBox>(find.ancestor(
      of: find.text('2025-06-01 10:00'),
      matching: find.byType(SizedBox),
    ));
    expect(dateCellSizedBox.width, 70);

    final viewButtonFinder = find.widgetWithText(ElevatedButton, 'View').first;
    final viewButton = tester.widget<ElevatedButton>(viewButtonFinder);
    expect(viewButton.style?.backgroundColor?.resolve({}), const Color(0xFF2B5F91));
    final buttonSizedBox = tester.widget<SizedBox>(find.ancestor(
      of: viewButtonFinder,
      matching: find.byType(SizedBox),
    ));
    expect(buttonSizedBox.width, 90);
    expect(buttonSizedBox.height, 30);

    await tester.tap(viewButtonFinder);
    await tester.pumpAndSettle();
    expect(calledDiagnosisId, 1, reason: 'onViewDetails should be called with diagnosisId 1');

    final secondViewButtonFinder = find.widgetWithText(ElevatedButton, 'View').at(1);
    await tester.tap(secondViewButtonFinder);
    await tester.pumpAndSettle();
    expect(calledDiagnosisId, 2, reason: 'onViewDetails should be called with diagnosisId 2');
  });
}