part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class MessageSent extends ChatState {}

class ResponseReceived extends ChatState {}
