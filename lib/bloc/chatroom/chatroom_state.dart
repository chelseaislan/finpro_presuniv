// @dart=2.9
// 38/41 01

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ChatroomState extends Equatable {
  const ChatroomState();

  @override
  List<Object> get props => [];
}

class ChatroomInitialState extends ChatroomState {}

class ChatroomLoadingState extends ChatroomState {}

class ChatroomLoadedState extends ChatroomState {
  final Stream<QuerySnapshot> messageStream;

  const ChatroomLoadedState({this.messageStream});

  @override
  List<Object> get props => [messageStream];
}
// 38/41 01