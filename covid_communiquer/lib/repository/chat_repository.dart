import 'package:covid_communiquer/api_connection/api_connection.dart';
import 'package:covid_communiquer/model/api_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final _base = "https://communiquer.herokuapp.com";
final _chatEndpoint = "/api/chat/";
final _chatUrl = _base + _chatEndpoint;

class ChatRepository {
  final String sessionId;

  ChatRepository(this.sessionId);
  

  List <Option> parseOptions (List<dynamic> parsed) {
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