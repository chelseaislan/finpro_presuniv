// @dart=2.9
// Start 28/41 01
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object> get props => [];
}

// Loading and loaduser state
class LoadingState extends MatchesState {}

// compare states based on matched list & selected list
class LoadUserState extends MatchesState {
  final Stream<QuerySnapshot> matchedList;
  final Stream<QuerySnapshot> selectedList;

  LoadUserState({this.matchedList, this.selectedList});

  @override
  List<Object> get props => [matchedList, selectedList];
}
