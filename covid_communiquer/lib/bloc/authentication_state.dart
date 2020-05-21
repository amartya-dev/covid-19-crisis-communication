part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String displayName;
  final String sessionId;

  const Authenticated(this.displayName, this.sessionId);

  @override
  List<Object> get props => [displayName,sessionId];

  @override
  String toString() => 'Authenticated { displayName $displayName , sessionID $sessionId}';
}

class Unauthenticated extends AuthenticationState {}
