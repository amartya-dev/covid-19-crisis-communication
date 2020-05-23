import 'package:covid_communiquer/bloc/authentication_bloc.dart';
import 'package:covid_communiquer/chat/graph_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_communiquer/chat/bloc/chat_bloc.dart';
import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:covid_communiquer/chat/chat_space.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String sessionId;
  final ChatRepository chatRepository;

  HomeScreen({
    Key key,
    @required this.name,
    @required this.sessionId,
    @required this.chatRepository,
  });

  @override
  _HomeState createState() => new _HomeState(
      name: name, sessionId: sessionId, chatRepository: chatRepository);
}

class _HomeState extends State<HomeScreen> {
  final String name;
  final String sessionId;
  final ChatRepository chatRepository;

  _HomeState({this.name, this.sessionId, this.chatRepository});

  int _currentIndex = 0;
  final List<Widget> _children = [GraphSpace()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          )
        ],
      ),
      body: _currentIndex == 0
          ? BlocProvider<ChatBloc>(
              create: (context) => ChatBloc(chatRepository: this.chatRepository)
                ..add(ChatStarted(sessionId: this.sessionId)),
              child: ChatSpace(
                name: this.name,
                sessionId: this.sessionId,
              ),
            )
          : _children[0],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.chat),
            title: new Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.table_chart),
            title: new Text('Statistics'),
          ),
        ],
      ),
    );
  }
}
