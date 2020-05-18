import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:equatable/equatable.dart';
import 'package:covid_communiquer/chat/home_screen.dart';
import 'package:covid_communiquer/api_connection/api_connection.dart';
import 'package:covid_communiquer/repository/user_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserRepository _userRepository;
  final _base = "https://communiquer.herokuapp.com";
  final _sessionEndpoint = "/api/create_session/";
  final _chatEndpoint = "/api/chat/";

  ChatBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  ChatState get initialState => MessageSent();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is OnMessage) {
      yield* _mapOnMessageToState(event.message);
    }
    if (event is OnRespond) {
      yield* _mapOnRespondToState(event.response);
    }
  }

  Stream<ChatState> _mapOnMessageToState(String message) async* {
    yield MessageSent();
  }

  Stream<ChatState> _mapOnRespondToState(String response) async* {
    yield ResponseReceived();
  }
}
