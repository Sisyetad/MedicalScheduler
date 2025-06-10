import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

abstract class ReceptionistRepository {
  Future<List<Receptionist>> getAllReceptionists();
  Future<Receptionist?> getReceptionistById(int receptionistId);
  Future<Receptionist> createReceptionist(EmployeeRequestModel receptionist);
  Future<void> updateReceptionist(Receptionist receptionist);
}
