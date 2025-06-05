import '../../../domain/entities/response/role.dart';

abstract class RoleDataSource {
  Future<List<Role>> getAllRoles();
  Future<Role?> getRoleById(int id);
}
