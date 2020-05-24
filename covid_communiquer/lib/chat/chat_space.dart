import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_communiquer/chat/bloc/chat_bloc.dart';
import 'package:covid_communiquer/model/chat_model.dart';

class ChatSpace extends StatefulWidget {
  final String name;
  final String sessionId;

  ChatSpace({Key key, @required this.name, @required this.sessionId})
      : super(key: key);

  @override
  _ChatSpace createState() => new _ChatSpace(name: name, sessionId: sessionId);
}

class _ChatSpace extends State<ChatSpace> {
  final String name;
  final String sessionId;
  final TextEditingController _textController = new TextEditingController();
  List<Messages> messages;

  ChatBloc _chatBloc;

  _ChatSpace({@required this.name, @required this.sessionId});

  @override
  void initState() {
    super.initState();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(listener: (context, state) {
      if (state is Loading) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Communicating ..."),
                CircularProgressIndicator(),
              ],
            ),
          ));
      }
      if (state is Loaded) {
        messages = state.messages;
      }
    }, child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome $name !')),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, index) {
                return ChatMessage(
                  name: messages[index].type ? this.name : "Bot",
                  text: messages[index].message,
                  type: messages[index].type,
                  options:
                      messages[index].type ? [null] : messages[index].options,
                  sessionId: sessionId,
                );
              },
              itemCount: messages.length,
            ),
          ),
          Divider(
            height: 2.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: new Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
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
            ),
          ),
        ],
      );
    }));
  }

  void _handleSubmitted(String text) {
    messages.insert(0, Messages(message: text, type: true));
    BlocProvider.of<ChatBloc>(context).add(OnMessage(
        message: text,
        sessionId: this.sessionId,
        isOption: false,
        messageDisplay: text));
    _textController.clear();
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
  final bool type;
  final List<Options> options;
  final String sessionId;

  ChatMessage({this.text, this.name, this.type, this.options, this.sessionId});

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
              child: Column(
                children: <Widget>[
                  Text(text),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: options.map((Options option) {
                      if ((option.value) != null) {
                        return Container(
                            padding: EdgeInsets.all(1.0),
                            child: Column(
                              children: <Widget>[
                                Container(
//                                  decoration: BoxDecoration(
//                                    border: Border(
//                                      left: BorderSide(
//                                          width: 5.0,
//                                          style: BorderStyle.solid,
//                                          color: Colors.lightBlueAccent),
////                                        top: BorderSide(
////                                            width: 3.0,
////                                            color: Colors.lightBlue.shade600),
////                                        right: BorderSide(
////                                            width: 3.0,
////                                            color: Colors.lightBlue.shade600),
////                                        bottom: BorderSide(
////                                            width: 3.0,
////                                            color: Colors.lightBlue.shade600)
//                                    ),
//                                  ),
                                  child: RaisedButton(
                                    child: Text((option.label).toString()),
                                    color: Colors.white,
                                    textColor: Colors.orange,
                                    padding: EdgeInsets.all(10.0),
                                    splashColor: Colors.limeAccent,
                                    onPressed: () {
                                      BlocProvider.of<ChatBloc>(context).add(
                                          OnMessage(
                                              message:
                                                  (option.value).toString(),
                                              sessionId: sessionId,
                                              isOption: true,
                                              messageDisplay:
                                                  (option.label).toString()));
                                    },
                                  ),
                                ),
                                Container(
                                  child: SizedBox(
                                    height: 10.0,
                                  ),
                                )
                              ],
                            ));
                      } else {
                        return Container(
                          height: 0.0,
                          width: 0.0,
                        );
                      }
                    }).toList(),
                  )
                ],
              ),
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
            this.name[0],
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
