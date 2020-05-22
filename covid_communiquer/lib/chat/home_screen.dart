import 'package:covid_communiquer/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_communiquer/chat/bloc/chat_bloc.dart';
import 'package:covid_communiquer/repository/chat_repository.dart';
import 'package:covid_communiquer/chat/chat_space.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final String sessionId;
  final ChatRepository _chatRepository;

  HomeScreen({
    Key key,
    @required this.name,
    @required String sessionId,
    @required ChatRepository chatRepository,
  })  : assert(chatRepository != null),
        _chatRepository = chatRepository,
        sessionId = sessionId,
        super(key: key);

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
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut()
              );
            },
          )
        ],
      ),
      body: BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(chatRepository: this._chatRepository)
          ..add(ChatStarted(sessionId: this.sessionId)),
        child: ChatSpace(
          name: this.name,
          sessionId: this.sessionId,
        ),
      ),
    );
  }
}
