import 'package:covid_communiquer/api_connection/api_connection.dart';
import 'package:covid_communiquer/model/api_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

class ChatRepository {
  final String sessionId;

  ChatRepository(this.sessionId);
  
//  Future <Response> getResponse(Message message){
//
//  }

  List <Option> parseOptions (String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Option>((json) => Option.fromJson(json)).toList();
  }

  Future<Response> getResponse(Message message) async {
    final String adminToken = await getAdminToken();
    final http.Response response = await http.post(
        _chatUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'TOKEN $adminToken'
        },
        body: <String, String>{
          'session_id': message.sessionId.toString(),
          'message': message.message.toString()
        }
    );
    if (response.statusCode == 200){
      return Response(
          responseText: json.decode(response.body)["response"],
          options: parseOptions(
              json.decode(response.body)["options"].toString()
          )
      );
    }
    else{
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  }
}