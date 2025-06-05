import '../entities/response/role.dart';

abstract class RoleAssignmentRepository {
  Future<List<Role>> getallRoles();
  Future<Role?> getRolebyId(int roleId);
}
