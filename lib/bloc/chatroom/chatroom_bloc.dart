// @dart=2.9
// 38/41 03

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/bloc/chatroom/bloc.dart';
import 'package:finpro_max/models/message_detail.dart';
import 'package:finpro_max/repositories/chatroom_repository.dart';
import 'package:meta/meta.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  ChatroomRepository _chatroomRepository;

  ChatroomBloc({@required ChatroomRepository chatroomRepository})
      : assert(chatroomRepository != null),
        _chatroomRepository = chatroomRepository;

  @override
  ChatroomState get initialState => ChatroomInitialState();

  @override
  Stream<ChatroomState> mapEventToState(ChatroomEvent event) async* {
    if (event is SendMessageEvent) {
      yield* _mapSendMessageToState(messageDetail: event.messageDetail);
    }
    if (event is MessageStreamEvent) {
      yield* _mapStreamToState(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
      );
    }
  }

  Stream<ChatroomState> _mapSendMessageToState(
      {MessageDetail messageDetail}) async* {
    await _chatroomRepository.sendMessage(messageDetail: messageDetail);
  }

  Stream<ChatroomState> _mapStreamToState(
      {String currentUserId, String selectedUserId}) async* {
    yield ChatroomLoadingState();
    Stream<QuerySnapshot> messageStream = _chatroomRepository.getMessages(
      currentUserId: currentUserId,
      selectedUserId: selectedUserId,
    );
    yield ChatroomLoadedState(messageStream: messageStream);
  }
}
// 38/41 03