import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUserModel {
  final String name;
  final String lastMsg;
  final String image;
  final String email;
  final Timestamp? lastMsgTime;

  ChatUserModel(
      {required this.name,
      required this.lastMsg,
      required this.image,
      required this.email,
      required this.lastMsgTime});

  factory ChatUserModel.jsonData(json) {
    return ChatUserModel(
        name: json['userNameOfUser'],
        lastMsg: json['lastMsg'],
        image: json['imageOfUser'],
        email: json['email'],
        lastMsgTime: json['msgTime']);
  }
}
