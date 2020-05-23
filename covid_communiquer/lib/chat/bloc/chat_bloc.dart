import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:covid_communiquer/model/api_model.dart';
import 'package:covid_communiquer/model/chat_model.dart';

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
      Response dummyMessage = await chatRepository.getResponse(
          new Message(message: "hello", sessionId: event.sessionId));
      Options initialOption = Options();
      Messages initialMessage = Messages(
          message:
              "Hello I'am COVID 19 crisis communication bot, let's start chatting",
          type: false,
          options: [initialOption]);
      final messages = [initialMessage];
      yield Loaded(messages: messages, sessionId: event.sessionId);
    }

    if (event is OnMessage) {
      final chatState = state;
      if (chatState is Loaded) {
//        Messages sentMessage = Messages(message: event.message, type: true);
        Message message =
            Message(message: event.message, sessionId: event.sessionId);
        Response response = await chatRepository.getResponse(message);
        List<Options> optionsFormed = [];
        for (int i = 0; i < response.options.length; i++) {
          Options option = Options(
              label: response.options[i].label,
              value: response.options[i].value);
          optionsFormed.add(option);
        }
        Messages responseMessage =
            Messages(message: response.responseText, type: false, options: optionsFormed);

        List<Messages> messagesFormed = [
          responseMessage
//          , sentMessage
        ];
        messagesFormed.addAll(chatState.messages);
        yield Loaded(messages: messagesFormed, sessionId: chatState.sessionId);
      }
    }
  }
}
