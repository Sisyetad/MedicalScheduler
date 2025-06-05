import 'package:medical_scheduler/data/source/data_source/role_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/repository/role_repo.dart';

class RoleAssignmentRepositoryImpl implements RoleAssignmentRepository {
  final RoleDataSource dataSource;

  RoleAssignmentRepositoryImpl(this.dataSource);

  @override
  Future<Role?> getRolebyId(int roleId) async {
    return await dataSource.getRoleById(roleId);
  }

  @override
  Future<List<Role>> getallRoles() async {
    return await dataSource.getAllRoles();
  }
}
