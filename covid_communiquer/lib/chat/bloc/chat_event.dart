part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class OnMessage extends ChatEvent {
  final String message;

  const OnMessage({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'OnMessage { message :$message }';
}

class OnRespond extends ChatEvent {
  final String response;

  const OnRespond({@required this.response});

  @override
  List<Object> get props => [response];

  @override
  String toString() => 'OnRespond { response :$response }';
}
