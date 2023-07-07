import 'package:cosmos_client/Chat/Models/msg_Model.dart';
import 'package:cosmos_client/Chat/widgets/otherMsg_widget.dart';
import 'package:cosmos_client/Chat/widgets/ownMsg_widget.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GroupPage extends StatefulWidget {
  final String workflowName;
  final String name;
  final String userId;
  final String chatId;

  const GroupPage({
    Key? key,
    required this.name,
    required this.userId,
    required this.workflowName,
    required this.chatId,
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
    fetchMessages(); // Fetch existing chat messages
  }

  void fetchMessages() {
    Dio().get('$baseUrls/common/chat/${widget.chatId}').then((fetchedMessages) {
      setState(() {
        messages = List<MsgModel>.from(fetchedMessages.data['messages']
            .map((e) => MsgModel.fromJson(e))
            .toList());
      });
    }).catchError((error) {
      print('Error fetching messages: $error');
    });
  }

  void sendMsg(String content, String? senderName) {
    MsgModel ownMsg = MsgModel(
      content: content,
      user: widget.chatId,
      time: DateTime.now().toUtc().toIso8601String(),
    );

    Dio().patch('$baseUrls/common/chat', data: {
      'head': {'_id': widget.chatId},
      'set': {
        '\$push': {
          "messages": {
            "user": widget.userId,
            "time": DateTime.now().toUtc().toIso8601String(),
            "content": content,
          }
        }
      }
    }).then((value) {
      setState(() {
        messages.add(ownMsg);
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupPage(
                  name: widget.name,
                  userId: widget.userId,
                  workflowName: widget.workflowName,
                  chatId: widget.chatId))); //widget.workflow['chat'])));
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
                if (messages[index].user == widget.userId) {
                  return OwnMSgWidget(
                      content: messages[index].content,
                      user: messages[index].user,
                      userName: widget.name);
                } else {
                  return OtherMSgWidget(
                      content: messages[index].content,
                      user: messages[index].user);
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
