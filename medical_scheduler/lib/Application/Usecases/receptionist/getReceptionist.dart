// domain/usecases/receptionist/get_all_receptionists.dart
import '../../../domain/entities/response/receptionist.dart';
import '../../../domain/repository/receptionist_repo.dart';

class GetAllReceptionists {
  final ReceptionistRepository repository;

  GetAllReceptionists(this.repository);

  Future<List<Receptionist>> call() => repository.getAllReceptionists();
}
