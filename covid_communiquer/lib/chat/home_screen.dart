import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_communiquer/bloc/authentication_bloc.dart';
import 'package:covid_communiquer/chat/bloc/chat_bloc.dart';
import 'package:covid_communiquer/chat/chat_space.dart';
//import 'package:covid_communiquer/api_connection/api_connection.dart';

//class HomeScreen extends StatefulWidget {
//  final String name;
//  final ChatRepository chatRepository;
//  final String sessionID;
//
//  HomeScreen({Key key, @required this.name, @required this.sessionID , @required this.chatRepository}) : super(key: key);
//
//  @override
//  _HomeScreen createState() => new _HomeScreen(name: name, chatRepository: chatRepository, sessionID: sessionID);
//}
//
//class _HomeScreen extends State<HomeScreen> {
//  final String name;
//  final ChatRepository chatRepository;
//  final String sessionID;
//  final List<ChatMessage> _messages = <ChatMessage>[];
//  final TextEditingController _textController = new TextEditingController();
//
//  _HomeScreen({@required this.name, @required this.chatRepository, @required this.sessionID});
//
//  Widget _buildTextComposer() {
//    return IconTheme(
//      data: IconThemeData(color: Theme.of(context).accentColor),
//      child: new Row(
//        children: <Widget>[
//          Flexible(
//            child: TextField(
//              controller: _textController,
//              onSubmitted: _handleSubmitted,
//              decoration: InputDecoration(
//                  hintText: "Send a message",
//                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
//                  contentPadding: const EdgeInsets.all(20.0)),
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 6.0),
//            child: IconButton(
//              icon: Icon(Icons.send),
//              onPressed: () => _handleSubmitted(_textController.text),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.orange,
//        title: Text('Home'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.exit_to_app),
//            onPressed: () {
//              BlocProvider.of<AuthenticationBloc>(context).add(
//                LoggedOut(),
//              );
//            },
//          )
//        ],
//      ),
//      body: Column(
//        children: <Widget>[
//          Flexible(
//            child: ListView.builder(
//              padding: EdgeInsets.all(8.0),
//              reverse: true,
//              itemBuilder: (_, int index) => _messages[index],
//              itemCount: _messages.length,
//            ),
//          ),
//          Divider(
//            height: 2.0,
//          ),
//          Container(
//            decoration: BoxDecoration(color: Theme.of(context).cardColor),
//            child: _buildTextComposer(),
//          )
//        ],
//      ),
//    );
//  }
//
//  void _handleSubmitted(String text) {
//    _textController.clear();
//    ChatMessage message = new ChatMessage(
//      text: text,
//      name: this.name,
//      type: true,
//    );
//    setState(() {
//      _messages.insert(0, message);
//    });
////    _chatbloc.add(OnMessage(message: text));
////    response(text);
//  }
//}
//
////void response(query) async {
////  print("Inside response()");
////  final String adminToken = await getAdminToken();
////  final String _chatURL = _base + _chatEndpoint;
////  try {
////    final http.Response resp = await http.post(_chatURL,
////        headers: <String, String>{
////          'Content-Type': 'application/json; charset=UTF-8',
////          'Authorization': 'TOKEN $adminToken'
////        },
////        body: jsonEncode(
////            <String, String>{'session_id': _sessionID, 'message': query}));
////    if (resp.statusCode == 200) {
////      ChatMessage message = ChatMessage(
////        text: (json.decode(resp.body))['response'],
////        name: "Bot",
////        type: false,
////      );
////    } else {
////      print(json.decode(resp.body).toString());
////      throw Exception(json.decode(resp.body));
////    }
////  } catch (err) {
////    print(err);
////  }
////}
//

class HomeScreen extends StatelessWidget {
  final String name;
  final String sessionID;
  final ChatRepository _chatRepository;

  HomeScreen({
    Key key,
    @required String name,
    @required String sessionID,
    @required ChatRepository chatRepository,
  })  : assert(sessionID != null),
        this.name = name,
        this.sessionID = sessionID,
        _chatRepository = chatRepository,
        super(key: key);

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
        body: BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(chatRepository: _chatRepository),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: ChatSpace(
                    name: this.name,
                    sessionID: this.sessionID),
              )
            ],
          ),
        ));
  }
}
