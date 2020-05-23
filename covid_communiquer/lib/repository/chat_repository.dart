import 'package:covid_communiquer/api_connection/api_connection.dart';
import 'package:covid_communiquer/model/api_model.dart';
import 'package:covid_communiquer/dao/user_dao.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

final _base = "https://communiquer.herokuapp.com";
final _chatEndpoint = "/api/chat/";
final _chatUrl = _base + _chatEndpoint;

class ChatRepository {
  final String sessionId;
  final UserDao daoObject = UserDao();

  ChatRepository(this.sessionId);
  

  List <Option> parseOptions (List<dynamic> parsed) {
    return parsed.map<Option>((json) => Option.fromJson(json)).toList();
  }

  Future<Response> getResponse(Message message) async {
    final String adminToken = await getAdminToken();
    final String userToken = await daoObject.getUserToken(0);
    final http.Response response = await http.post(
        _chatUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'TOKEN $userToken'
        },
        body: jsonEncode(message.toDatabaseJson())
    );
    if (response.statusCode == 200){
      print(json.decode(response.body)["response"]);
      return Response(
          responseText: json.decode(utf8.decode(response.bodyBytes))["response"],
          options: parseOptions(
              json.decode(response.body)["options"]
          )
      );
    }
    else{
      throw Exception("Session Error");
    }
  }
}