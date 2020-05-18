import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_communiquer/repository/user_repository.dart';
import 'package:covid_communiquer/api_connection/api_connection.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final _base = "https://communiquer.herokuapp.com";
  final _sessionEndpoint = "/api/create_session/";
  final _chatEndpoint = "/api/chat/";
  String _sessionID;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final name = await _userRepository.getUser();
      yield Authenticated(name);
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    _sessionID = await _createSession();
    print(_sessionID);
    yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    _userRepository.signOut();
    yield Unauthenticated();
  }

  Future<String> _createSession() async {
    print("Inside createSession function()");
    final _createSessionURL = _base + _sessionEndpoint;
    final String adminToken = await getAdminToken();
    String sessionID = "";
    final http.Response resp =
        await http.post(_createSessionURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'TOKEN $adminToken'
    });
    if (resp.statusCode == 200) {
      sessionID = (json.decode(resp.body))['session_id'];
      print("Session ID : " + sessionID);
      return sessionID;
    } else {
      print(json.decode(resp.body).toString());
      throw Exception(json.decode(resp.body));
    }
  }
}
