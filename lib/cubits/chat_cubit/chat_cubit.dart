import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessageCollection);

  void sendMessage({required String message, required String email}){
    messages.add({
      "message": message,
      "createdAt": DateTime.now(),
      "id":email
    });
    emit(ChatSent());
  }

  void getMessage(){
    messages.orderBy('createdAt',descending: true).snapshots().listen((event) {
      List<Message> listMessage=[];
      for(var doc in event.docs){
        listMessage.add(Message.fromjson(doc));
      }
        emit(ChatSeen(messages: listMessage));
    });
  }

}
