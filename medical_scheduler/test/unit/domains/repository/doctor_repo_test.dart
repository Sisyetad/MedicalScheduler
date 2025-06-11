import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medical_scheduler/domain/repository/doctor_repo.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';

// Mock class for DoctorRepository
class MockDoctorRepository extends Mock implements DoctorRepository {}

void main() {
  late MockDoctorRepository mockRepo;

  setUp(() {
    mockRepo = MockDoctorRepository();
  });

  group('DoctorRepository', () {
    test('getAllDoctors returns list of Doctor', () async {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 1,
        username: 'Dr. Smith',
        email: 'drsmith@example.com',
        password: 'pass',
        role: role,
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        specialization: 'Cardiology',
        branch: null,
        isSignedUp: true,
      );

      when(mockRepo.getAllDoctors()).thenAnswer((_) async => [doctor]);

      final result = await mockRepo.getAllDoctors();

      expect(result, isA<List<Doctor>>());
      expect(result.length, 1);
      expect(result.first.doctorId, 1);
    });

    test('createDoctor returns created Doctor', () async {
      final role = Role(roleId: 1, name: 'Doctor');
      final doctor = Doctor(
        doctorId: 2,
        username: 'Dr. Jane',
        email: 'drjane@example.com',
        password: 'pass2',
        role: role,
        createdAt: '2024-02-01',
        updatedAt: '2024-02-02',
        specialization: 'Neurology',
        branch: null,
        isSignedUp: true,
      );
      final requestModel = EmployeeRequestModel(
        username: 'Dr. Jane',
        email: 'drjane@example.com',
        branchId: 5,
      );

      when(mockRepo.createDoctor(requestModel)).thenAnswer((_) async => doctor);

      final result = await mockRepo.createDoctor(requestModel);

      expect(result, isA<Doctor>());
      expect(result.username, 'Dr. Jane');
      expect(result.specialization, 'Neurology');
      expect(result.doctorId, 2);
    });
  });
}