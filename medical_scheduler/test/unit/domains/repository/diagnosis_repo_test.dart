import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/domain/repository/diagnosis_repo.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';
import 'package:medical_scheduler/data/model/RequestModel/diagnosis_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

// Mock class for DiagnosisRepository
class MockDiagnosisRepository extends Mock implements DiagnosisRepository {}

void main() {
  late MockDiagnosisRepository mockRepo;

  setUp(() {
    mockRepo = MockDiagnosisRepository();
  });

  tearDown(() {
    reset(mockRepo);
  });

  group('DiagnosisRepository', () {
    test('getAllDiagnoses returns list of DiagnosisHistory', () async {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );
      final patient = Patient(
        patientId: 2,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        phoneNumber: '1234567890',
        gender: 'Male',
        dateOfBirth: '1990-01-01',
        registeredBy: null,
      );
      final diagnosisHistory = DiagnosisHistory(
        diagnosisId: 100,
        diagnosisName: 'Flu',
        doctor: doctor,
        medication: 'Rest',
        createdTime: '2024-06-01',
        comment: 'Mild symptoms',
        patient: patient,
        updatedAt: '2024-06-02',
        visible: true,
      );

      when(mockRepo.getAllDiagnoses()).thenAnswer((_) async => [diagnosisHistory]);

      final result = await mockRepo.getAllDiagnoses();

      expect(result, isA<List<DiagnosisHistory>>());
      expect(result.length, 1);
      expect(result.first.diagnosisId, 100);
    });

    test('getDiagnosisById returns DiagnosisHistory', () async {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );
      final patient = Patient(
        patientId: 2,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        phoneNumber: '1234567890',
        gender: 'Male',
        dateOfBirth: '1990-01-01',
        registeredBy: null,
      );
      final diagnosisHistory = DiagnosisHistory(
        diagnosisId: 100,
        diagnosisName: 'Flu',
        doctor: doctor,
        medication: 'Rest',
        createdTime: '2024-06-01',
        comment: 'Mild symptoms',
        patient: patient,
        updatedAt: '2024-06-02',
        visible: true,
      );

      when(mockRepo.getDiagnosisById(100)).thenAnswer((_) async => diagnosisHistory);

      final result = await mockRepo.getDiagnosisById(100);

      expect(result, isA<DiagnosisHistory>());
      expect(result?.diagnosisId, 100);
    });

    test('createDiagnosis returns created DiagnosisHistory', () async {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );
      final patient = Patient(
        patientId: 2,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        phoneNumber: '1234567890',
        gender: 'Male',
        dateOfBirth: '1990-01-01',
        registeredBy: null,
      );
      final diagnosisHistory = DiagnosisHistory(
        diagnosisId: 100,
        diagnosisName: 'Flu',
        doctor: doctor,
        medication: 'Rest',
        createdTime: '2024-06-01',
        comment: 'Mild symptoms',
        patient: patient,
        updatedAt: '2024-06-02',
        visible: true,
      );
      final requestModel = DiagnosisRequestModel(
        diagnosisName: 'Flu',
        patientId: 2,
        doctorId: 1,
        visible: true,
        medication: 'Rest',
        comment: 'Mild symptoms',
      );
      when(mockRepo.createDiagnosis(requestModel)).thenAnswer((_) async => diagnosisHistory);

      final result = await mockRepo.createDiagnosis(requestModel);

      expect(result, isA<DiagnosisHistory>());
      expect(result.diagnosisName, 'Flu');
    });

    test('updateDiagnosis completes without error', () async {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
      );
      final patient = Patient(
        patientId: 2,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        phoneNumber: '1234567890',
        gender: 'Male',
        dateOfBirth: '1990-01-01',
        registeredBy: null,
      );
      final diagnosisHistory = DiagnosisHistory(
        diagnosisId: 100,
        diagnosisName: 'Flu',
        doctor: doctor,
        medication: 'Rest',
        createdTime: '2024-06-01',
        comment: 'Mild symptoms',
        patient: patient,
        updatedAt: '2024-06-02',
        visible: true,
      );
      when(mockRepo.updateDiagnosis(diagnosisHistory)).thenAnswer((_) async {});

      await mockRepo.updateDiagnosis(diagnosisHistory);

      verify(mockRepo.updateDiagnosis(diagnosisHistory)).called(1);
    });

    test('viewDiagnosis returns true', () async {
      when(mockRepo.viewDiagnosis(100)).thenAnswer((_) async => true);

      final result = await mockRepo.viewDiagnosis(100);

      expect(result, isTrue);
    });
  });
}