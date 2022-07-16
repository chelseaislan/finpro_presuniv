// @dart=2.9
// 33/41 03
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/bloc/message/bloc.dart';
import 'package:finpro_max/repositories/message_repository.dart';
import 'package:meta/meta.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository _messageRepository;

  MessageBloc({@required MessageRepository messageRepository})
      : assert(messageRepository != null),
        _messageRepository = messageRepository;

  @override
  MessageState get initialState => MessageInitialState();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is ChatStreamEvent) {
      yield* _mapChatStreamToState(currentUserId: event.currentUserId);
    }
  }

  Stream<MessageState> _mapChatStreamToState({String currentUserId}) async* {
    yield ChatLoadingState();
    Stream<QuerySnapshot> chatStream =
        _messageRepository.getChats(userId: currentUserId);
    yield ChatLoadedState(chatStream: chatStream);
  }
}
// 33/41 03 END