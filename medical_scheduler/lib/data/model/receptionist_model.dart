
import 'package:medical_scheduler/data/model/branch_model.dart';
import 'package:medical_scheduler/data/model/role_model.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

class ReceptionistModel extends Receptionist {
  ReceptionistModel({
    required super.receptionistId,
    required super.username,
    required super.email,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
    required super.branch,
    required super.isSignedUp,
  }) : super(role: RoleModel(roleId: 5, name: 'Receptionist'));

  factory ReceptionistModel.fromJson(Map<String, dynamic> json) {
    return ReceptionistModel(
      receptionistId: json['receptionist_id'], 
      username: json['name'], 
      email: json['email'],
      password: json['password'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      branch: BranchModel.fromJson(json['branch']) as Branch,
      isSignedUp: json['is_signed_up'], 
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'receptionist_id': receptionistId, 
      'name': username,  
      'email': email,
      'password': passwordHash, 
      'role': (role as RoleModel).toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'branch': (branch as BranchModel).toJson(),
      'is_signed_up': isSignedUp, 
    };
  }
}
