// data/repositories/receptionist_repository_impl.dart
import 'package:medical_scheduler/domain/entities/request/receptionist_request.dart';
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
    ReceptionistRequest receptionist,
  ) async {
    return await dataSource.createReceptionist(receptionist);
  }

  @override
  Future<void> updateReceptionist(Receptionist receptionist) async {
    await dataSource.updateReceptionist(receptionist);
  }

  @override
  Future<void> deleteReceptionist(int id) async {
    await dataSource.deleteReceptionist(id);
  }
}
