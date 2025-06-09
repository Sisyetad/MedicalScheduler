import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';

abstract class DoctorDataSrc {
  Future<List<Doctor>> getAllDoctors();
  Future<Doctor> createDoctor(DoctorRequest doctor);
  Future<void> updateDoctor(Doctor doctor);
  Future<void> deleteDoctor(int id);
}
