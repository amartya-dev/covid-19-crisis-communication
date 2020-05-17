part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnMessage extends ChatEvent {}

class OnRespond extends ChatEvent {}
