class MsgModel {
  String? id;
  String? time;
  String type;
  String msg;
  String sender;

  MsgModel({
    this.id,
    this.time,
    required this.msg,
    required this.type,
    required this.sender,
  });
}

// class MsgModel {
//   String? id;
//   String? user;
//   DateTime time;
//   String content;

//   MsgModel({
//     this.id,
//     this.user,
//     required this.time,
//     required this.content,
//   });
// }

// class ChatModel {
//   String? id;
//   String workflow;
//   List<MsgModel> messages;

//   ChatModel({
//     this.id,
//     required this.workflow,
//     required this.messages,
//   });
// }
