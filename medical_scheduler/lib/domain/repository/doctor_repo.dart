import 'package:medical_scheduler/domain/entities/response/doctor.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getAllDoctors();
}
