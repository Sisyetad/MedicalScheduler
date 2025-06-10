import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class Doctor extends User {
  final int doctorId;
  final String? specialization;
  final Branch? branch;
  final bool? isSignedUp;
  Doctor({
    required this.doctorId,
    required super.username,
    required super.email,
    super.password,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
    this.specialization,
    this.branch,
    this.isSignedUp,
  }) : super(userId: doctorId);

  @override
  Doctor copyWith({
    String? username,
    String? email,
    String? password,
    String? updatedAt,
    String? specialization,
    Branch? branch,
    bool? isSignedUp,
  }) {
    return Doctor(
      doctorId: doctorId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? "",
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now().toIso8601String(),
      specialization: specialization ?? this.specialization,
      branch: branch ?? this.branch,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      role: role,
    );
  }
}
