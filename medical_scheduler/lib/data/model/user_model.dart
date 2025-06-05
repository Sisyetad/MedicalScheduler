
import 'package:medical_scheduler/data/model/role_model.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class UserModel extends User {
  UserModel({
    required super.userId,
    required super.username,
    required super.email,
    required super.password,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
     return UserModel(
      userId: json['user_id'],
      username: json['name'],
      email: json['email'],
      password: json['password'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'], 
      role: RoleModel.fromJson(json['role']),
    );
  }
}



// final role = RoleModel.fromJson(json['role']);
    
//     switch (role.roleId) {
//       case 4:
//         return DoctorModel.fromJson(json) as UserModel;
//       case 3:
//         return PatientModel.fromJson(json) as UserModel;
//       case 5:
//         return ReceptionistModel.fromJson(json) as UserModel;
//       case 2:
//         return BranchModel.fromJson(json) as UserModel;
//       case 1:
//         return HeadofficeModel.fromJson(json) as UserModel;
//       default:
//         throw Exception('Unknown user role: $role');
//     }