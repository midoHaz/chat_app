import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';


class CustomMessage extends StatelessWidget {
  const CustomMessage({Key? key, required this.message, required this.delivered, required this.seen}) : super(key: key);
  final Message message;
  final bool delivered;
  final bool seen;
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: message.message,
      color: kPrimaryColor,
      tail: true,
      delivered: true,
      seen: true,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class CustomMessageForFr extends StatelessWidget {
  const CustomMessageForFr({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: message.message,
      color: const Color(0xFFE8E8EE),
      tail: true,
      isSender: false,
      textStyle: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
