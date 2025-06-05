// data/repositories/doctor_repository_impl.dart
import 'package:medical_scheduler/data/source/data_source/doctor_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/repository/doctor_repo.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorDataSrc dataSource;

  DoctorRepositoryImpl(this.dataSource);

  @override
  Future<List<Doctor>> getAllDoctors() async {
    return await dataSource.getAllDoctors();
  }
}
