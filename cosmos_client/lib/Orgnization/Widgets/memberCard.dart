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
            const FlutterLogo(),
            const SizedBox(width: 10),
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
              onPressed: widget.onRemoveMember,
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
