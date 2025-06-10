import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

abstract class ReceptionistRepository {
  Future<List<Receptionist>> getAllReceptionists();
  Future<Receptionist?> getReceptionistById(int receptionistId);
  Future<Receptionist> createReceptionist(EmployeeRequest receptionist);
  Future<void> updateReceptionist(Receptionist receptionist);
  Future<void> deleteReceptionist(int id);
}
