import 'package:medical_scheduler/domain/entities/response/headoffice.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class Branch extends User {
  final int branchId;
  final String? location;
  final String? contactPhone;
  final String? specialization;
  final bool? isSignedUp;
  final HeadOffice? headOffice;
  

  Branch({
    required this.branchId,
    required super.username,
    required super.email,
    super.password,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
    this.contactPhone,
    this.specialization,
    this.isSignedUp,
    this.headOffice,
    this.location,
  }):super(userId: branchId);

  @override
  Branch copyWith({
    String? username,
    String? email,
    String? password,
    String? updatedAt,
    String? location,
    String? contactPhone,
    String? specialization,
    bool? isSignedUp,
  }) {
    return Branch(
      branchId: branchId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? "",
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      contactPhone: contactPhone?? this.contactPhone,
      specialization: specialization?? this.specialization,
      isSignedUp: isSignedUp?? this.isSignedUp,
      headOffice: headOffice,
      location: location?? this.location,
      role: role,
    );
  }
}
