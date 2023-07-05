// class MsgModel {
//   String? id;
//   String? time;
//   String type;
//   String msg;
//   String sender;

//   MsgModel({
//     this.id,
//     this.time,
//     required this.msg,
//     required this.type,
//     required this.sender,
//   });
// }

class MsgModel {
  String? id;
  String user;
  String time;
  String content;

  MsgModel({
    this.id,
    required this.time,
    required this.content,
    required this.user,
  });

  factory MsgModel.fromJson(Map<String, dynamic> json) {
    return MsgModel(time: json['time'], content: json['content'], user: json['user']);
  }
}

class ChatModel {
  String? id;
  String workflow;
  List<MsgModel> messages;

  ChatModel({
    this.id,
    required this.workflow,
    required this.messages,
  });
}
