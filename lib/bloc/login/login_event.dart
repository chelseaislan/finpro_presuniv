// @dart=2.9
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  // @override
  // String toString() => 'EmailChanged {email: $email}';
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  // @override
  // String toString() => 'PasswordChanged {password: $password}';
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed(
      {@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
