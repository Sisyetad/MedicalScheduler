import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/source/data_source/role_data_src.dart';
import '../../../domain/entities/response/role.dart';
import '../../model/ResponseModel/role_model.dart';

class RoleDataSourceImpl implements RoleDataSource {
  final Dio dio;

  RoleDataSourceImpl(this.dio);

  @override
  Future<List<Role>> getAllRoles() async {
    final response = await dio.get('/roles');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => RoleModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load roles');
    }
  }

  @override
  Future<Role?> getRoleById(int id) async {
    final response = await dio.get('/roles/$id');

    if (response.statusCode == 200) {
      return RoleModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
