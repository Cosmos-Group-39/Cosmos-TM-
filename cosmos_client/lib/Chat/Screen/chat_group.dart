import 'package:cosmos_client/Chat/Models/msg_Model.dart';
import 'package:cosmos_client/Chat/widgets/otherMsg_widget.dart';
import 'package:cosmos_client/Chat/widgets/ownMsg_widget.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupPage extends StatefulWidget {
  final String name;
  final String userId;
  const GroupPage({Key? key, required this.name, required this.userId})
      : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  IO.Socket? socket;
  List<MsgModel> messages = [];
  TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('connect into frontend');
      socket!.on("sendMsgServer", (content) {
        print(content);
        if (content["userId"] != widget.userId) {
          setState(() {
            messages.add(
              MsgModel(
                content: content["content"],
                type: content["type"],
                user: content["senderName"],
                time: DateTime.now(), // change
              ),
            );
          });
        }
      });
    });
  }

  void sendMsg(String content, String? senderName) {
    MsgModel ownMsg = MsgModel(
        content: content,
        type: "ownMsg",
        user: senderName ?? "Unknown",
        time: DateTime.now());
    messages.add(ownMsg);
    setState(() {
      messages;
    });
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "content": content,
      "senderName": senderName ?? "Unknown",
      "userId": widget.userId,
    });
  }

// //Delete chat history
//   deleteChat() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: kAlertBoxBorderStyle,
//           title: const Icon(
//             Icons.backspace,
//             size: 60.0,
//             color: Colors.green,
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Text(
//                   'Are You Sure ?',
//                   style: kAlertBoxTopicTextStyle,
//                 ),
//               ),
//               const Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 20, left: 17),
//                   child: Text(
//                     'You want to clear the chat !',
//                     style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 style: kAlertBoxButtonStyle, //Elevated button style
//                 onPressed: () {
//                   setState(() {
//                     listMsg.clear();
//                   });
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Clear',
//                   style: kAlertBoxButtonTextStyle, //Elevated button Text style
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//       },
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: const Text(
          'Workflow Name',
          style: TextStyle(
              fontSize: 20, letterSpacing: 0.4, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if (messages[index].type == "ownMsg") {
                    return OwnMSgWidget(
                        content: messages[index].content,
                        user: messages[index].user!);
                  } else {
                    return OtherMSgWidget(
                        content: messages[index].content,
                        user: messages[index].user!);
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: "Type here ... ",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          String content = _msgController.text;
                          if ((content.isNotEmpty)) {
                            sendMsg(content, widget.name); //
                            _msgController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.purple,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
