import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Models/orgModels.dart';
import 'package:flutter/material.dart';

class MemberCardWidget extends StatefulWidget {
  final OrgMembersModel member;
  final VoidCallback onRemoveMember;
  final VoidCallback onCardPressed;

  const MemberCardWidget({
    Key? key,
    required this.member,
    required this.onRemoveMember,
    required this.onCardPressed,
  }) : super(key: key);

  @override
  _MemberCardWidgetState createState() => _MemberCardWidgetState();
}

class _MemberCardWidgetState extends State<MemberCardWidget> {
  late bool isAdmin;

  @override
  void initState() {
    super.initState();
    isAdmin = widget.member.isAdmin;
  }

//Remove Member Card
  void removeMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          title: const Icon(
            Icons.remove_circle_outline_sharp,
            size: 60.0,
            color: Colors.green,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are You Sure ?',
                  style: kAlertBoxTopicTextStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 17),
                  child: Text(
                    'You want to remove the Member !',
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle, //Elevated button style
                onPressed: () {
                  widget.onRemoveMember();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Remove',
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
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kPrimaryColor, kSecondaryColor],
          ),
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 15),
            const CircleAvatar(),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.member.name,
                    style: const TextStyle(
                      color: kBackgroundColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    isAdmin ? 'Admin' : 'Member',
                    style: const TextStyle(
                      fontSize: 10,
                      color: kBackgroundColor,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 50),
            PopupMenuButton<bool>(
              onSelected: (bool value) {
                setState(() {
                  // Update the member role
                  isAdmin = value;
                  widget.member.isAdmin = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<bool>>[
                  const PopupMenuItem<bool>(
                    value: false,
                    child: Text('Member'),
                  ),
                  const PopupMenuItem<bool>(
                    value: true,
                    child: Text('Admin'),
                  ),
                ];
              },
              icon: const Icon(
                Icons.more_vert,
                color: kBackgroundColor,
              ),
            ),
            IconButton(
              onPressed: removeMember,
              icon: const Icon(
                Icons.close,
                color: kBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
