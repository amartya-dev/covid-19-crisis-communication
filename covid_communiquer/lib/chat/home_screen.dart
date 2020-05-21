import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_communiquer/bloc/authentication_bloc.dart';
import 'package:covid_communiquer/chat/bloc/chat_bloc.dart';
import 'package:covid_communiquer/chat/chat_space.dart';
//import 'package:covid_communiquer/api_connection/api_connection.dart';

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
