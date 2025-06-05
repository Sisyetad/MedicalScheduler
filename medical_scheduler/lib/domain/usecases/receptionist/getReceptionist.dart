// domain/usecases/receptionist/get_all_receptionists.dart
import '../../entities/response/receptionist.dart';
import '../../repository/receptionist_repo.dart';

class GetAllReceptionists {
  final ReceptionistRepository repository;

  GetAllReceptionists(this.repository);

  Future<List<Receptionist>> call() => repository.getAllReceptionists();
}
