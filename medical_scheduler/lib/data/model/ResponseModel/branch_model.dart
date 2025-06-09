import 'package:medical_scheduler/data/model/ResponseModel/headoffice_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/role_model.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';

class BranchModel extends Branch {
  BranchModel({
    required super.branchId,
    required super.username,
    required super.email,
    super.password,
    required super.createdAt,
    required super.updatedAt,
    super.isSignedUp,
    super.specialization,
    super.contactPhone,
    super.headOffice,
    super.location,
  }) : super(role: RoleModel(roleId: 4, name: 'Doctor'));

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branchId: json['branch_id'] ?? json['user_id'],
      username: json['username'] ?? json['name'],
      email: json['email'],
      password: json['password'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      specialization: json['specialization'] ?? "",
      contactPhone: json['contact_phone'] ?? "",
      location: json['location'] ?? "",
      isSignedUp: json['is_signed_up'] ?? false,
      headOffice: json['headoffice'] != null
          ? HeadofficeModel.fromJson(json['headoffice']) as HeadOffice
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'branch_id': branchId,
      'name': username,
      'contact_email': email,
      'password': passwordHash,
      'specialization': specialization,
      'contact_phone': contactPhone,
      'location': location,
      'is_signed_up': isSignedUp,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'headoffice': (headOffice as HeadofficeModel).toJson(),
      'role': (role as RoleModel).toJson(),
    };
  }
}
