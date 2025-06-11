import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/domain/repository/patient_repo.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

// Mock class for PatientRepository
class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late MockPatientRepository mockRepo;

  setUp(() {
    mockRepo = MockPatientRepository();
  });

  group('PatientRepository', () {
    test('getAllPatients returns list of Patient', () async {
      final role = Role(roleId: 2, name: 'Patient');
      final patient = Patient(
        patientId: 1,
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

      when(mockRepo.getAllPatients()).thenAnswer((_) async => [patient]);

      final result = await mockRepo.getAllPatients();

      expect(result, isA<List<Patient>>());
      expect(result.length, 1);
      expect(result.first.patientId, 1);
    });

    test('getPatientById returns Patient', () async {
      final role = Role(roleId: 2, name: 'Patient');
      final patient = Patient(
        patientId: 1,
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

      when(mockRepo.getPatientById(1)).thenAnswer((_) async => patient);

      final result = await mockRepo.getPatientById(1);

      expect(result, isA<Patient>());
      expect(result?.patientId, 1);
    });

    test('createPatient completes without error', () async {
      final requestModel = PatientRequestModel(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phone: '1234567890',
        address: '123 Main St',
        dateofBirth: '1990-01-01',
        gender: 'Male',
        registeredby: 1,
      );

      await mockRepo.createPatient(requestModel);

      verify(mockRepo.createPatient(requestModel)).called(1);
    });

    test('updatePatient completes without error', () async {
      final role = Role(roleId: 2, name: 'Patient');
      final patient = Patient(
        patientId: 1,
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

      when(mockRepo.updatePatient(patient)).thenAnswer((_) async {});

      await mockRepo.updatePatient(patient);

      verify(mockRepo.updatePatient(patient)).called(1);
    });

    test('deletePatient completes without error', () async {
      when(mockRepo.deletePatient(1)).thenAnswer((_) async {});

      await mockRepo.deletePatient(1);

      verify(mockRepo.deletePatient(1)).called(1);
    });
  });
}
