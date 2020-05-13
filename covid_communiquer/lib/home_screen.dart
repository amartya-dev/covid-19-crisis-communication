import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:covid_communiquer/bloc/authentication_bloc.dart';
import 'package:covid_communiquer/api_connection/api_connection.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  _HomeScreen createState() => new _HomeScreen(name: name);
}

class _HomeScreen extends State<HomeScreen> {
  final String name;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  final _base = "https://communiquer.herokuapp.com";
  final _sessionEndpoint = "/api/create_session/";
  final _chatEndpoint = "/api/chat/";
  String _sessionID;

  @override
  void initState() {
//    _getThingsOnStartup().then((value){
//      print('Async done');
//    });
    _createSession();
    super.initState();
  }

  _HomeScreen({@required this.name});

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: new Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: "Send a message",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          )
        ],
      ),
    );
  }
  void _createSession() async {
    print("Inside createSession function()");
    final _createSessionURL = _base + _sessionEndpoint;
    final String adminToken = await getAdminToken();
    final http.Response response =
    await http.post(_createSessionURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'TOKEN $adminToken'
    });
    if (response.statusCode == 200) {
//      return Token.fromJson(json.decode(response.body));
      _sessionID = (json.decode(response.body))['session_id'];
      print(_sessionID);
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  }
  void response(query) async {
    print("Inside response()");
    final String adminToken = await getAdminToken();
    final String _chatURL = _base + _chatEndpoint;
    print("Session ID:  "+  _sessionID);
    try{
      final http.Response response = await http.post(_chatURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'TOKEN $adminToken'
          },
          body: jsonEncode(<String, String>{
            'session_id': _sessionID,
            'message': query
          })
      );
      print("Response" + response.body);
      if (response.statusCode == 200) {
//      return Token.fromJson(json.decode(response.body));
        print((json.decode(response.body))['response']);
//      _sessionID = (json.decode(response.body))['session_id'];
      } else {
        print(json.decode(response.body).toString());
        throw Exception(json.decode(response.body));
      }
      ChatMessage message = ChatMessage(
        text: (json.decode(response.body))['response'],
        name: "Bot",
        type: false,
      );
      setState(() {
        _messages.insert(0, message);
      });
    }catch(err){
      print(err);
    }


  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: this.name,
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    response(text);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(
            height: 2.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
  final bool type;

  ChatMessage({this.text, this.name, this.type});

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          child: Text('B'),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(),
              child: Text(text),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              this.name,
              style: Theme.of(context).textTheme.subhead,
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(text),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          child: Text(
            (this.name[0]).toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
