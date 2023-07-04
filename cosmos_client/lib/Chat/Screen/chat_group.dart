import 'package:cosmos_client/Chat/Models/msg_Model.dart';
import 'package:cosmos_client/Chat/widgets/otherMsg_widget.dart';
import 'package:cosmos_client/Chat/widgets/ownMsg_widget.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GroupPage extends StatefulWidget {
  final String workflowName;
  final String name;
  final String userId;

  const GroupPage({
    Key? key,
    required this.name,
    required this.userId,
    required this.workflowName,
  }) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<MsgModel> messages = [];
  TextEditingController _msgController = TextEditingController();
  String userName = 'Anonymous';

  @override
  void initState() {
    super.initState();
    FlutterSecureStorage().read(key: 'userName').then((userName) {
      setState(() {
        this.userName = userName ?? 'Anonymous';
      });
    });
    fetchMessages(); // Fetch existing chat messages
  }

  void fetchMessages() {
    // Call the API service function to fetch existing messages
    fetchChatMessages().then((fetchedMessages) {
      setState(() {
        messages = fetchedMessages;
      });
    }).catchError((error) {
      print('Error fetching messages: $error');
    });
  }

  void sendMsg(String content, String? senderName) {
    MsgModel ownMsg = MsgModel(
      content: content,
      type: "ownMsg",
      user: senderName ?? "Unknown",
      time: DateTime.now(),
    );

    // Call the API service function to send the message
    sendChatMessage(ownMsg).then((_) {
      setState(() {
        messages.add(ownMsg);
      });
    }).catchError((error) {
      print('Error sending message: $error');
    });

    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: Text(
          widget.workflowName,
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
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
                  return OwnMsgWidget(
                    content: messages[index].content,
                    user: messages[index].user!,
                    userName: userName, // Pass the userName value here
                  );
                } else {
                  return OtherMsgWidget(
                    content: messages[index].content,
                    user: messages[index].user!,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          String content = _msgController.text;
                          if (content.isNotEmpty) {
                            sendMsg(content, widget.name);
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
