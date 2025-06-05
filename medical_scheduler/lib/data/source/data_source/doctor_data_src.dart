import 'package:medical_scheduler/domain/entities/response/doctor.dart';

abstract class DoctorDataSrc {
  Future<List<Doctor>> getAllDoctors();
  Future<void> createDoctor(Doctor doctor);
  Future<void> updateDoctor(Doctor doctor);
  Future<void> deleteDoctor(int id);
}
