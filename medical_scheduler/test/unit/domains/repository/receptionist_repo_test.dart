import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/domain/repository/receptionist_repo.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';

// Mock class for ReceptionistRepository
class MockReceptionistRepository extends Mock implements ReceptionistRepository {}

void main() {
  late MockReceptionistRepository mockRepo;

  setUp(() {
    mockRepo = MockReceptionistRepository();
  });

  group('ReceptionistRepository', () {
    test('getAllReceptionists returns list of Receptionist', () async {
      final role = Role(roleId: 3, name: 'Receptionist');
      final branch = Branch(
        branchId: 10,
        username: 'branchuser',
        email: 'branch@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        contactPhone: '1234567890',
        specialization: 'General',
        isSignedUp: true,
        headOffice: null,
        location: 'Bole',
      );
      final receptionist = Receptionist(
        receptionistId: 1,
        username: 'recept1',
        email: 'recept1@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        branch: branch,
        isSignedUp: true,
      );

      when(mockRepo.getAllReceptionists()).thenAnswer((_) async => [receptionist]);

      final result = await mockRepo.getAllReceptionists();

      expect(result, isA<List<Receptionist>>());
      expect(result.length, 1);
      expect(result.first.receptionistId, 1);
    });

    test('getReceptionistById returns Receptionist', () async {
      final role = Role(roleId: 3, name: 'Receptionist');
      final branch = Branch(
        branchId: 10,
        username: 'branchuser',
        email: 'branch@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        contactPhone: '1234567890',
        specialization: 'General',
        isSignedUp: true,
        headOffice: null,
        location: 'Bole',
      );
      final receptionist = Receptionist(
        receptionistId: 1,
        username: 'recept1',
        email: 'recept1@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        branch: branch,
        isSignedUp: true,
      );

      when(mockRepo.getReceptionistById(1)).thenAnswer((_) async => receptionist);

      final result = await mockRepo.getReceptionistById(1);

      expect(result, isA<Receptionist>());
      expect(result?.receptionistId, 1);
    });

    test('createReceptionist returns created Receptionist', () async {
      final role = Role(roleId: 3, name: 'Receptionist');
      final branch = Branch(
        branchId: 10,
        username: 'branchuser',
        email: 'branch@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        contactPhone: '1234567890',
        specialization: 'General',
        isSignedUp: true,
        headOffice: null,
        location: 'Bole',
      );
      final receptionist = Receptionist(
        receptionistId: 2,
        username: 'recept2',
        email: 'recept2@example.com',
        password: 'pass2',
        role: role,
        createdAt: '2024-02-01',
        updatedAt: '2024-02-02',
        branch: branch,
        isSignedUp: true,
      );
      final requestModel = EmployeeRequestModel(
        username: 'recept2',
        email: 'recept2@example.com',
        branchId: 10,
      );

      when(mockRepo.createReceptionist(requestModel)).thenAnswer((_) async => receptionist);

      final result = await mockRepo.createReceptionist(requestModel);

      expect(result, isA<Receptionist>());
      expect(result.username, 'recept2');
      expect(result.receptionistId, 2);
    });

    test('updateReceptionist completes without error', () async {
      final role = Role(roleId: 3, name: 'Receptionist');
      final branch = Branch(
        branchId: 10,
        username: 'branchuser',
        email: 'branch@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        contactPhone: '1234567890',
        specialization: 'General',
        isSignedUp: true,
        headOffice: null,
        location: 'Bole',
      );
      final receptionist = Receptionist(
        receptionistId: 2,
        username: 'recept2',
        email: 'recept2@example.com',
        password: 'pass2',
        role: role,
        createdAt: '2024-02-01',
        updatedAt: '2024-02-02',
        branch: branch,
        isSignedUp: true,
      );

      when(mockRepo.updateReceptionist(receptionist)).thenAnswer((_) async {});

      await mockRepo.updateReceptionist(receptionist);

      verify(mockRepo.updateReceptionist(receptionist)).called(1);
    });
  });
}