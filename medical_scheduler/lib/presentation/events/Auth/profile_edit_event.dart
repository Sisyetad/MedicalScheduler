import 'package:flutter/widgets.dart';

abstract class ProfileEditEvent {}

class UpdateUserName extends ProfileEditEvent {
  final String username;
  UpdateUserName(this.username);
}

class UpdateEmail extends ProfileEditEvent {
  final String email;
  UpdateEmail(this.email);
}

class UpdateCurrentPassword extends ProfileEditEvent {
  final String currentPassword;
  UpdateCurrentPassword(this.currentPassword);
}

class UpdateNewPassword extends ProfileEditEvent {
  final String newPassword;
  UpdateNewPassword(this.newPassword);
}

class UpdateConfirmPassword extends ProfileEditEvent {
  final String confirmPassword;
  UpdateConfirmPassword(this.confirmPassword);
}

class SubmitProfileUpdate extends ProfileEditEvent {
  final String username;
  final String email;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  SubmitProfileUpdate({
    required this.username,
    required this.email,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
