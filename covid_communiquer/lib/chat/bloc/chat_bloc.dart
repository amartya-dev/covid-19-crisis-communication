import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:covid_communiquer/model/api_model.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({@required this.chatRepository});

  @override
  ChatState get initialState => Loading();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatStarted) {
      final messages = [
        "Hello I'am COVID 19 crisis communication bot, let's start chatting"
      ];
      yield Loaded(messages: messages, sessionId: event.sessionId);
    }

    if (event is OnMessage) {
      final chatState = state;

      if (chatState is Loaded) {
        Message message =
            Message(message: event.message, sessionId: event.sessionId);
        Response response = await chatRepository.getResponse(message);
        List<String> messagesFormed = [response.responseText.toString()];
        messagesFormed.addAll(chatState.messages);
        yield Loaded(messages: messagesFormed, sessionId: chatState.sessionId);
      }
    }
  }
}
