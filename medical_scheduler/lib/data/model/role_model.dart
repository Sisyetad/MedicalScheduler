import 'package:medical_scheduler/domain/entities/response/role.dart';

class RoleModel extends Role {
  RoleModel({
    required super.roleId,
    required super.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      roleId: json['role_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'name': name,
    };
  }

}
