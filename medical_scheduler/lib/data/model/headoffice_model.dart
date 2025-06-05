import 'package:medical_scheduler/data/model/role_model.dart';
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';

class HeadofficeModel extends HeadOffice {
  HeadofficeModel({
    required super.headofficeId,
    required super.name,
    required super.contactEmail,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
    required super.contactPhone,
    required super.location,
  }) : super(role: RoleModel(roleId: 1, name: 'HeadOffice'));

  factory HeadofficeModel.fromJson(Map<String, dynamic> json) {
    return HeadofficeModel(
      headofficeId: json['headoffice_id'],
      name: json['name'],
      contactEmail: json['contact_email'],
      password: json['password'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      contactPhone: json['contact_phone'],
      location: json['location'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'headoffice_id': headofficeId,
      'name': username,
      'contact_email': email,
      'contact_phone': contactPhone,
      'location': location,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': (role as RoleModel).toJson(),
    };
  }
}
