import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class Receptionist extends User {
  final int receptionistId;
  final Branch branch;
  final bool isSignedUp;
  Receptionist({
    required this.receptionistId,
    required super.username,
    required super.email,
    super.password,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
    required this.branch,
    required this.isSignedUp,
  }) : super(userId: receptionistId);

  @override
  Receptionist copyWith({
    String? username,
    String? email,
    String? password,
    String? updatedAt,
    Branch? branch,
    bool? isSignedUp,
  }) {
    return Receptionist(
      receptionistId: receptionistId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? "",
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branch: branch ?? this.branch,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      role: role,
    );
  }
}
