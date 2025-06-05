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

class SubmitLogin extends AuthEvent {
  final BuildContext context;
  SubmitLogin(this.context);
}
