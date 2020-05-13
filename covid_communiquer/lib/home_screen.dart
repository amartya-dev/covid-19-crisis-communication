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
              decoration: InputDecoration(
                  hintText: "Send a message",
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  contentPadding: const EdgeInsets.all(20.0)),
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
    final http.Response resp =
        await http.post(_createSessionURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'TOKEN $adminToken'
    });
    if (resp.statusCode == 200) {
//      return Token.fromJson(json.decode(response.body));
      _sessionID = (json.decode(resp.body))['session_id'];
      print(_sessionID);
      response("hello");
//      Future.delayed(const Duration(milliseconds: 2000), () {
//        response("hello");
//      });

    } else {
      print(json.decode(resp.body).toString());
      throw Exception(json.decode(resp.body));
    }
  }

  void response(query) async {
    print("Inside response()");
    final String adminToken = await getAdminToken();
    final String _chatURL = _base + _chatEndpoint;
    try {
      final http.Response resp = await http.post(_chatURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'TOKEN $adminToken'
          },
          body: jsonEncode(
              <String, String>{'session_id': _sessionID, 'message': query}));
      if (resp.statusCode == 200) {
//        if((json.decode(resp.body))['response'] == "I don't know the answer to that yet"){
//          response("hello");
//        }
        ChatMessage message = ChatMessage(
          text: (json.decode(resp.body))['response'],
          name: "Bot",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
        });
      } else {
        print(json.decode(resp.body).toString());
        throw Exception(json.decode(resp.body));
      }
    } catch (err) {
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
