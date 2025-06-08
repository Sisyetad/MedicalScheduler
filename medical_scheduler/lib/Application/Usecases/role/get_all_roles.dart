// domain/usecases/role/get_all_roles.dart
import '../../../domain/entities/response/role.dart';
import '../../../domain/repository/role_repo.dart';

class GetAllRoles {
  final RoleAssignmentRepository repository;

  GetAllRoles(this.repository);

  Future<List<Role>> call() => repository.getallRoles();
}
