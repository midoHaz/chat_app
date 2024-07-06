import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);
  factory Message.fromjson(jsonData){
    return Message(jsonData[kMessageData],jsonData["id"]);
  }
}