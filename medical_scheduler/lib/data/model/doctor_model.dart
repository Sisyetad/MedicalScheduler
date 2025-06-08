import 'package:medical_scheduler/data/model/role_model.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';
import 'package:medical_scheduler/data/model/branch_model.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.doctorId,
    required super.username,
    required super.email,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
    super.branch,
    super.isSignedUp,
    super.specialization,
  }) : super(role: RoleModel(roleId: 4, name: 'Doctor'));

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctor_id'] ?? json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      branch: json['branch'] != null
          ? BranchModel.fromJson(json['branch']) as Branch
          : null,
      isSignedUp: json['is_signed_up'] ?? true,
      specialization: json['specialty'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'name': username,
      'email': email,
      'password': passwordHash,
      'role': (role as RoleModel).toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'branch': branch != null ? (branch as BranchModel).toJson() : null,
      'is_signed_up': isSignedUp,
      'specialty': specialization,
    };
  }
}
