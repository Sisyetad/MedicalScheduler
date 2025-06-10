import 'package:flutter/widgets.dart';

abstract class AuthEvent {}

class UpdateEmail extends AuthEvent {
  final String email;
  UpdateEmail(this.email);
}

class UpdatePassword extends AuthEvent {
  final String password;
  UpdatePassword(this.password);
}

class UpdateName extends AuthEvent {
  final String username;
  UpdateName(this.username);
}

class SubmitLogin extends AuthEvent {
  final String email;
  final String password;
  SubmitLogin({required this.email, required this.password});
}

class Logout extends AuthEvent {
  final BuildContext context;
  Logout(this.context);
}

class SubmitSignup extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String role;
  SubmitSignup({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });
}


