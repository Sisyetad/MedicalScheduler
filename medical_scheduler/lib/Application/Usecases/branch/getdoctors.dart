// domain/usecases/doctor/get_all_doctors.dart
import '../../../domain/entities/response/doctor.dart';
import '../../../domain/repository/doctor_repo.dart';

class GetAllDoctors {
  final DoctorRepository repository;

  GetAllDoctors(this.repository);

  Future<List<Doctor>> call() => repository.getAllDoctors();
}
