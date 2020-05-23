part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class Loading extends ChatState {}

class Loaded extends ChatState {
  final List<Messages> messages;
  final List<Option> options;
  final String sessionId;

  const Loaded({@required this.messages,@required this.options, @required this.sessionId});

  @override
  List<Object> get props => [messages];

  @override 
  String toString() => 'Loaded { messages: ${messages.length} }';
}
