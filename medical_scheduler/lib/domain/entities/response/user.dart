import 'package:bcrypt/bcrypt.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

class User {
  final int userId;
  final String _username;
  final String _email;
  final String? _passwordHash;
  final Role role;
  final String createdAt;
  final String updatedAt;

  User({
    required this.userId,
    required String username,
    required String email,
    String? password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  }) : _username = username,
       _email = email,
       _passwordHash = password;

  String get username => _username;
  String get email => _email;
  String? get passwordHash => _passwordHash;

  bool verifyPassword(String inputPassword) {
    return BCrypt.checkpw(inputPassword, _passwordHash!);
  }

  User copyWith({
    String? username,
    String? email,
    String? password,
    String? updatedAt,
  }) {
    return User(
      userId: userId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? "",
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
