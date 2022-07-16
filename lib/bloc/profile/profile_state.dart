// @dart=2.9
import 'package:equatable/equatable.dart';
import 'package:finpro_max/models/user.dart';

// Equatable compares variuos instance of states without boilerplate code
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final User currentUser;
  ProfileLoadedState(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}
