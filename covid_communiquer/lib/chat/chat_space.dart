import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package:covid_communiquer/chat/bloc/chat_bloc.dart';
import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:covid_communiquer/chat/home_screen.dart';

class ChatSpace extends StatefulWidget {
  final String name;
  final String sessionID;
//  final ChatRepository _chatRepository;

  ChatSpace({Key key,
    @required String name,
    @required String sessionID,
//    @required ChatRepository chatRepository
    })
      : assert(sessionID != null),
        this.name = name,
        this.sessionID = sessionID,
//        _chatRepository = chatRepository,
        super(key: key);

  State<ChatSpace> createState() =>
      _ChatSpaceState(
          name: this.name,
          sessionID: this.sessionID,
//          chatRepository: this._chatRepository
      );
}

class _ChatSpaceState extends State<ChatSpace> {
  ChatBloc _chatBloc;
  final String name;
  ChatRepository _chatRepository;
  final String sessionID;
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  _ChatSpaceState({
    @required String name,
    @required String sessionID,
//    @required ChatRepository chatRepository,
  })
      : this.name = name,
        this.sessionID = sessionID;
//        _chatRepository = chatRepository;
  @override
  void initState(){
    super.initState();
    _chatRepository = ChatRepository(sessionID);
    _chatBloc = ChatBloc(chatRepository: _chatRepository);
  }
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: new Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                  hintText: "Send a message",
                  hintStyle: TextStyle(color: Theme
                      .of(context)
                      .accentColor),
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

  void _handleSubmitted(String text) {
    print("Text : " + text);
    _textController.clear();
    print(_chatBloc);
    _chatBloc.add(OnMessage(message: text, sessionId: sessionID));
//    ChatMessage message = new ChatMessage(
//      text: text,
//      name: this.name,
//      type: true,
//    );
//    setState(() {
//      _messages.insert(0, message);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
//        _chatBloc  = BlocProvider.of<ChatBloc>(context);
        if (state is Loading) {

          _chatBloc.add(ChatStarted(sessionId: this.sessionID));
        } else {}
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          _chatBloc.add(ChatStarted(sessionId: sessionID));
          return
//            Scaffold(
//            body:
//            Column(
//              children: <Widget>[
//                Flexible(
//                  child: ListView.builder(
//                    padding: EdgeInsets.all(8.0),
//                    reverse: true,
//                    itemBuilder: (_, int index) =>
//                        ChatMessage(
//                            name: "Admin", text: "LOLOLOLOL", type: true),
//                    itemCount: 1,
//                  ),
//                ),
//                Divider(
//                  height: 2.0,
//                ),
                Container(
                  decoration: BoxDecoration(color: Theme
                      .of(context)
                      .cardColor),
                  child: _buildTextComposer(),
                );

//              ],
//            )
//          ,
//          );
        },
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
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
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
