import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/domain/repository/doctor_repo.dart';

class AddDoctor extends UseCase<Doctor, CreateDoctorParams> {
  final DoctorRepository doctorRepository;
  AddDoctor(this.doctorRepository);
  @override
  Future<Doctor> call(CreateDoctorParams params) {
    return doctorRepository.createDoctor(params.doctorRequest);
  }
}
