import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:covid_communiquer/model/api_model.dart';

final _base = "https://communiquer.herokuapp.com";
final _tokenEndpoint = "/api-token-auth/";
final _signUpEndpoint = "/api/users/";
final _sessionEndpoint = "/api/create_session/";
final _chatEndpoint = "/api/chat/";
final _tokenURL = _base + _tokenEndpoint;
final _signUpUrl = _base + _signUpEndpoint;
final _createSessionURL = _base + _sessionEndpoint;
final _chatUrl = _base + _chatEndpoint;

final _adminUsername = 'admin';
final _adminPassword = 'covidcrisis19';

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> getAdminToken() async {
  final UserLogin admin =
      UserLogin(username: _adminUsername, password: _adminPassword);
  final Token token = await getToken(admin);
  return token.token.toString();
}

Future<UserLogin> registerUser(UserSignup userSignup) async {
  final String adminToken = await getAdminToken();
  final http.Response response = await http.post(
    _signUpUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'TOKEN $adminToken'
    },
    body: jsonEncode(userSignup.toDatabaseJson()),
  );
  if (response.statusCode == 201) {
    final UserLogin user = UserLogin(
        username: userSignup.user.username, password: userSignup.user.password);
    return user;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> createSession() async {
  print("Inside createSession function()");
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

