// domain/usecases/headoffice/get_all_users.dart
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';
import 'package:medical_scheduler/domain/repository/admin_repo.dart';

class GetAllUsersFromHeadoffice {
  final HeadofficeRepository repository;

  GetAllUsersFromHeadoffice(this.repository);

  Future<List<HeadOffice>> call() => repository.getAllHeadoffices();
}
