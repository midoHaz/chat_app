import 'package:chat_app/components/CustomMessage.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chatPage';
  bool isSent=false;
  final bool _isSeen=false;
  List<Message> listMessage = [];
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/scholar.png",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "chat App",
                  style: TextStyle(
                      fontFamily: "Pacifico", color: kForeignColor),
                ),
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if(state is ChatSent){
                    isSent=true;
                  }else if(state is ChatSeen){
                    listMessage=state.messages;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _controller,
                    reverse: true,
                    itemBuilder: (context, index) =>
                    listMessage[index].id == email ? CustomMessage(
                      delivered: isSent,
                      seen: _isSeen,
                      message: listMessage[index],
                    ) : CustomMessageForFr(message: listMessage[index],),
                    itemCount: listMessage.length,
                  );
                },
              ),
            ),
            MessageBar(
              sendButtonColor: kPrimaryColor,
              onSend: (data) {
                _scrollDown();
              },
              actions: [
                InkWell(
                  child: const Icon(
                    Icons.add,
                    color: kPrimaryColor,
                    size: 24,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: const Icon(
                      Icons.camera_alt,
                      color: kPrimaryColor,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

