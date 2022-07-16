// @dart=2.9
// 33/41 01

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Equatable compares variuos instance of states without boilerplate code
abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitialState extends MessageState {}

class ChatLoadingState extends MessageState {}

class ChatLoadedState extends MessageState {
  final Stream<QuerySnapshot> chatStream;

  ChatLoadedState({this.chatStream});

  @override
  List<Object> get props => [chatStream];
}
// 33/41 01