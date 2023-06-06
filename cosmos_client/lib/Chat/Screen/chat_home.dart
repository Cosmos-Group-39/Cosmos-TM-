import 'package:cosmos_ran/Chat/Screen/chat_group.dart';
import 'package:cosmos_ran/Constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  final fromkey = GlobalKey<FormState>();

  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group Chat',
          style: TextStyle(
              fontSize: 20, letterSpacing: 0.4, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      body: Center(
        child: TextButton(
            onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Please enter your name "),
                    content: Form(
                      key: fromkey,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "user must have proper name";
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          nameController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (fromkey.currentState!.validate()) {
                            String name = nameController.text;
                            nameController.clear();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupPage(
                                  name: name,
                                  userId: uuid.v1(),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Enter",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            child: const Text(
              "Initiate Group Chat ",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 16,
              ),
            )),
      ),
    );
  }
}
