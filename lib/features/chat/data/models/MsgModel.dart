// ignore_for_file: file_names

class MsgModel {
  final String msg;
  final String emailSender;
  final String emailReceiver;
  final String id;

  MsgModel(
      {required this.msg,
      required this.emailSender,
      required this.emailReceiver,
      required this.id});

  factory MsgModel.jsonData(jsonData) {
    return MsgModel(
        msg: jsonData['msg'],
        emailSender: jsonData['sender'],
        emailReceiver: jsonData['reciever'],
        id: jsonData['id']);
  }
}
