// data/repositories/receptionist_repository_impl.dart
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';
import 'package:medical_scheduler/data/source/data_source/receptionist_data_src.dart';
import 'package:medical_scheduler/domain/repository/receptionist_repo.dart';

class ReceptionistRepositoryImpl implements ReceptionistRepository {
  final ReceptionistDataSrc dataSource;

  ReceptionistRepositoryImpl(this.dataSource);

  @override
  Future<List<Receptionist>> getAllReceptionists() async {
    return await dataSource.getAllReceptionists();
  }

  @override
  Future<Receptionist?> getReceptionistById(int id) async {
    return await dataSource.getReceptionistById(id);
  }

  @override
  Future<Receptionist> createReceptionist(
    EmployeeRequestModel receptionist,
  ) async {
    return await dataSource.createReceptionist(receptionist);
  }

  @override
  Future<void> updateReceptionist(Receptionist receptionist) async {
    await dataSource.updateReceptionist(receptionist);
  }
}
