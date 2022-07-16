// @dart=2.9

import 'package:equatable/equatable.dart';
import 'package:finpro_max/models/user.dart';

abstract class TaarufState extends Equatable {
  const TaarufState();

  @override
  List<Object> get props => [];
}

class TaarufLoadingState extends TaarufState {}

class TaarufLoadUserState extends TaarufState {
  final User currentUser, selectedUser;
  TaarufLoadUserState({this.currentUser, this.selectedUser});

  @override
  List<Object> get props => [currentUser, selectedUser];
}
