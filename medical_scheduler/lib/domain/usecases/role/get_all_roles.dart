// domain/usecases/role/get_all_roles.dart
import '../../entities/response/role.dart';
import '../../repository/role_repo.dart';

class GetAllRoles {
  final RoleAssignmentRepository repository;

  GetAllRoles(this.repository);

  Future<List<Role>> call() => repository.getallRoles();
}
