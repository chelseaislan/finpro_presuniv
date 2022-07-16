// @dart=2.9
// 33/41 02

import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class ChatStreamEvent extends MessageEvent {
  final String currentUserId;

  ChatStreamEvent({this.currentUserId});

  @override
  List<Object> get props => [currentUserId];
}
// 33/41 02