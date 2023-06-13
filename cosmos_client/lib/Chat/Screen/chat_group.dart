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
  List<MsgModel> listMsg = [];
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
      socket!.on("sendMsgServer", (msg) {
        print(msg);
        if (msg["userId"] != widget.userId) {
          setState(() {
            listMsg.add(
              MsgModel(
                  msg: msg["msg"],
                  type: msg["type"],
                  sender: msg["senderName"]),
            );
          });
        }
      });
    });
  }

  void sendMsg(String msg, String? senderName) {
    MsgModel ownMsg =
        MsgModel(msg: msg, type: "ownMsg", sender: senderName ?? "Unknown");
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": msg,
      "senderName": senderName ?? "Unknown",
      "userId": widget.userId,
    });
  }

//Delete chat history
  deleteChat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          title: const Icon(
            Icons.backspace,
            size: 60.0,
            color: Colors.green,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Are You Sure ?',
                  style: kAlertBoxTopicTextStyle,
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 17),
                  child: Text(
                    'You want to clear the chat !',
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle, //Elevated button style
                onPressed: () {
                  setState(() {
                    listMsg.clear();
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Clear',
                  style: kAlertBoxButtonTextStyle, //Elevated button Text style
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: deleteChat,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                itemCount: listMsg.length,
                itemBuilder: (context, index) {
                  if (listMsg[index].type == "ownMsg") {
                    return OwnMSgWidget(
                        msg: listMsg[index].msg, sender: listMsg[index].sender);
                  } else {
                    return OtherMSgWidget(
                        msg: listMsg[index].msg, sender: listMsg[index].sender);
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
                          String msg = _msgController.text;
                          if ((msg.isNotEmpty)) {
                            sendMsg(msg, widget.name); //
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
