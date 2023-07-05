import 'package:cosmos_client/Chat/Models/msg_Model.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

void sendMsg(MsgModel msg, List<MsgModel> msgs, String chatId) {
  Map<String, dynamic> jsonObject = {
    'user': msg.user,
    'time': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
        DateTime.parse(msg.time?.toString() ?? DateTime.now().toString())),
    'content': msg.content,
    'type': msg.type,
  };

  Dio().patch('$baseUrls/common/chat', data: {
    'head': {'_id': chatId},
    'set': {
      '\$push': {'works': jsonObject},
    },
  }).then((value) {
    msgs.add(msg);
    print('Work Added');
  }).catchError((error) => print(error));
}
