// @dart=2.9
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class InitialState extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userId;
  const Authenticated(this.userId);

  @override
  List<Object> get props => [userId];

  @override
  String toString() => "Authenticated {userId}";
}

class AuthenticatedButNotSet extends AuthenticationState {
  final String userId;
  const AuthenticatedButNotSet(this.userId);

  @override
  List<Object> get props => [userId];
}

class Unauthenticated extends AuthenticationState {}
