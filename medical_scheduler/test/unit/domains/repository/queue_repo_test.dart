import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/domain/repository/queue_repo.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/domain/entities/request/queue_request.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

// Mock class for DataQueueRepository
class MockDataQueueRepository extends Mock implements DataQueueRepository {}

void main() {
  late MockDataQueueRepository mockRepo;

  setUp(() {
    mockRepo = MockDataQueueRepository();
  });

  group('DataQueueRepository', () {
    test('getDataQueuebyId returns DataQueue', () async {
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
      final queue = DataQueue(
        status: 1,
        patient: patient,
        doctor: doctor,
        queueId: 100,
        createdAt: '2024-06-01',
        updatedAt: '2024-06-02',
      );

      when(mockRepo.getDataQueuebyId(100)).thenAnswer((_) async => queue);

      final result = await mockRepo.getDataQueuebyId(100);

      expect(result, isA<DataQueue>());
      expect(result?.queueId, 100);
    });

    test('getAllQueues returns list of DataQueue', () async {
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
      final queue = DataQueue(
        status: 1,
        patient: patient,
        doctor: doctor,
        queueId: 100,
        createdAt: '2024-06-01',
        updatedAt: '2024-06-02',
      );

      when(mockRepo.getAllQueues()).thenAnswer((_) async => [queue]);

      final result = await mockRepo.getAllQueues();

      expect(result, isA<List<DataQueue>>());
      expect(result.length, 1);
      expect(result.first.queueId, 100);
    });

    test('updateQueue completes without error', () async {
      when(mockRepo.updateQueue(100, 2)).thenAnswer((_) async {});

      await mockRepo.updateQueue(100, 2);

      verify(mockRepo.updateQueue(100, 2)).called(1);
    });

    test('createQueue returns created DataQueue', () async {
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
      final queue = DataQueue(
        status: 1,
        patient: patient,
        doctor: doctor,
        queueId: 100,
        createdAt: '2024-06-01',
        updatedAt: '2024-06-02',
      );
      final request = QueueRequest(
        doctorId: 1,
        patientId: 2,
        status: 1,
      );

      when(mockRepo.createQueue(request)).thenAnswer((_) async => queue);

      final result = await mockRepo.createQueue(request);

      expect(result, isA<DataQueue>());
      expect(result.queueId, 100);
    });
  });
}