class ChatUserModel {
  final String name;
  final String lastMsg;
  final String image;
  final String email;

  ChatUserModel(
      {required this.name,
      required this.lastMsg,
      required this.image,
      required this.email});

  factory ChatUserModel.jsonData(json) {
    return ChatUserModel(
        name: json['userNameOfUser'],
        lastMsg: json['lastMsg'],
        image: json['imageOfUser'],
        email: json['email']);
  }
}
