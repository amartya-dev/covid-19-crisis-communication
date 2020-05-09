import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_communiquer/repository/user_repository.dart';
import 'package:covid_communiquer/login/bloc/login_bloc.dart';
import 'package:covid_communiquer/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90.0),
                  ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.13
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1
                ),
                child: LoginForm(userRepository: _userRepository),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(150.0) 
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
