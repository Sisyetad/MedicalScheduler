// domain/usecases/doctor/get_all_doctors.dart
import '../../entities/response/doctor.dart';
import '../../repository/doctor_repo.dart';

class GetAllDoctors {
  final DoctorRepository repository;

  GetAllDoctors(this.repository);

  Future<List<Doctor>> call() => repository.getAllDoctors();
}
