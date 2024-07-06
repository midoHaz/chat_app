part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSent extends ChatState {}
class ChatSeen extends ChatState {
  List<Message> messages;
  ChatSeen({required this.messages});
}
