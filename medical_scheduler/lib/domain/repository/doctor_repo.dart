import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getAllDoctors();
  Future<Doctor> createDoctor(EmployeeRequestModel doctor);
}
