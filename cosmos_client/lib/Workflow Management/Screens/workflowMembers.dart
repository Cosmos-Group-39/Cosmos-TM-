import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

class WorkflowMembers extends StatefulWidget {
  const WorkflowMembers({Key? key}) : super(key: key);

  @override
  State<WorkflowMembers> createState() => _WorkflowMembersState();
}

class _WorkflowMembersState extends State<WorkflowMembers> {
  TextEditingController _workflowMemberController = TextEditingController();
  // Sample list of members
  List<String> members = ['Member 1', 'Member 2', 'Member 3'];
  Map<String, String> memberRoles = {}; // Map to store member roles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _workflowMemberController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: '    Add new members..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shadowColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    // Your button logic
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                final role = memberRoles[member] ?? 'Select Role';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(member),
                    subtitle: Text(role),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                    tileColor: Colors.blueAccent,
                    trailing: PopupMenuButton<String>(
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Owner',
                          child: Text('Owner'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Editor',
                          child: Text('Editor'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Viewer',
                          child: Text('Viewer'),
                        ),
                      ],
                      onSelected: (String value) {
                        setState(() {
                          memberRoles[member] =
                              value; // Update the selected role
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
