import 'package:medical_scheduler/domain/entities/request/receptionist_request.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

abstract class ReceptionistDataSrc {
  Future<List<Receptionist>> getAllReceptionists();
  Future<Receptionist?> getReceptionistById(int id);
  Future<Receptionist> createReceptionist(ReceptionistRequest receptionist);
  Future<void> updateReceptionist(Receptionist receptionist);
  Future<void> deleteReceptionist(int id);
}
