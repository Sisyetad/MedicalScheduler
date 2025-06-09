import 'package:medical_scheduler/core/usecases/base_useacase.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';
import 'package:medical_scheduler/domain/repository/receptionist_repo.dart';

class AddReceptionist extends UseCase<Receptionist, CreateReceptionistParams> {
  final ReceptionistRepository receptionistRepository;
  AddReceptionist(this.receptionistRepository);

  Future<Receptionist> call(params) {
    return receptionistRepository.createReceptionist(
      params.receptionistRequest,
    );
  }
}
