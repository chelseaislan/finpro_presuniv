// @dart=2.9
// Start of SearchState

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finpro_max/models/user.dart';

abstract class SearchProfileState extends Equatable {
  const SearchProfileState();

  @override
  List<Object> get props => [];
}

// 3 states to load user card

class SearchInitialState extends SearchProfileState {}

class SearchLoadingState extends SearchProfileState {}

class SearchLoadUserState extends SearchProfileState {
  final User user, currentUser;
  final Stream<QuerySnapshot> userList;

  SearchLoadUserState({this.user, this.currentUser, this.userList});

  @override
  List<Object> get props => [user, currentUser, userList];
}
// End of SearchState 01 21/41
