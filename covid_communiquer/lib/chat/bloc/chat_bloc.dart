import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_communiquer/repository/user_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatBloc, ChatState> {
  final UserRepository _userRepository;
  final _base = "https://communiquer.herokuapp.com";
  final _sessionEndpoint = "/api/create_session/";
  final _chatEndpoint = "/api/chat/";
  String _sessionID;

  ChatBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  ChatState get initialState => MessageSent();

  @override
  Stream<ChatState> mapEventToState(
    ChatBloc event,
  ) async* {
    if (event is OnMessage) {
      yield* _mapOnMessageToState();
    }
    if (event is OnRespond) {
      yield* _mapOnRespondToState();
    }
  }

  Stream<ChatState> _mapOnMessageToState() async* {
//    final isSignedIn = await _userRepository.isSignedIn();
//    if (isSignedIn){
//      final name = await _userRepository.getUser();
//      yield Authenticated(name);
//    } else {
//      yield Unauthenticated();
//    }
    yield MessageSent();
  }

  Stream<ChatState> _mapOnRespondToState() async* {
//    yield Authenticated(await _userRepository.getUser());
    yield ResponseReceived();
  }
}
