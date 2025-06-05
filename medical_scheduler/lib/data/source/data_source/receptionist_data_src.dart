import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

abstract class ReceptionistDataSrc {
  Future<List<Receptionist>> getAllReceptionists();
  Future<Receptionist?> getReceptionistById(int id);
  Future<void> createReceptionist(Receptionist receptionist);
  Future<void> updateReceptionist(Receptionist receptionist);
  Future<void> deleteReceptionist(int id);
}
