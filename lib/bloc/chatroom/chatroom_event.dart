// @dart=2.9
// 38/41 02

import 'package:equatable/equatable.dart';
import 'package:finpro_max/models/message_detail.dart';

abstract class ChatroomEvent extends Equatable {
  const ChatroomEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatroomEvent {
  final MessageDetail messageDetail;

  const SendMessageEvent({this.messageDetail});

  @override
  List<Object> get props => [messageDetail];
}

class MessageStreamEvent extends ChatroomEvent {
  final String currentUserId, selectedUserId;

  const MessageStreamEvent({this.currentUserId, this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}
// 38/41 02