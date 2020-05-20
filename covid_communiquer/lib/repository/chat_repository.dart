import 'package:covid_communiquer/api_connection/api_connection.dart';
import 'package:covid_communiquer/model/api_model.dart';
import 'package:meta/meta.dart';

class ChatRepository {
  final String sessionId;

  ChatRepository(this.sessionId);
  
  Future <Response> getResponse(Message message){
    
  }
}