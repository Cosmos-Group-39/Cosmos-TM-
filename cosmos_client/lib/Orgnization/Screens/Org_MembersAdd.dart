import 'package:cosmos_ran/Constants.dart';
import 'package:cosmos_ran/Orgnization/Widgets/Const_Texts.dart';
import 'package:cosmos_ran/Orgnization/Widgets/Members_Search.dart';
import 'package:flutter/material.dart';

class OrgAddMembers extends StatefulWidget {
  const OrgAddMembers({super.key});

  @override
  State<OrgAddMembers> createState() => _OrgAddMembersState();
}

class _OrgAddMembersState extends State<OrgAddMembers> {
  //Admin or member selection
  roleOrgmember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.person,
            size: 60.0,
            color: kPrimaryColor,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Select Member Role ?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Admin'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Member'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  removeOrgmember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.remove_circle,
            size: 60.0,
            color: Colors.deepOrange,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Are You Sure ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 17),
                child: Text(
                  'You want to remove this member !',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Members'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              orgAddMmeberText(context),
              orgMemberSearch(context),
              Container(
                color: kPrimaryColor.withOpacity(0.1),
                height: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    24 -
                    56,
                child: ListView.builder(
                  shrinkWrap: true,
                  restorationId: 'sampleItemListView',
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [kPrimaryColor, kSecondaryColor])),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const FlutterLogo(),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Member Name',
                                    style: TextStyle(
                                        color: kBackgroundColor,
                                        fontWeight: FontWeight.w800)),
                                Text('Admin',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: kBackgroundColor,
                                        fontWeight: FontWeight.w100))
                              ],
                            ),
                            const SizedBox(width: 50),
                            IconButton(
                                onPressed: roleOrgmember,
                                icon: const Icon(Icons.more_vert,
                                    color: kBackgroundColor)),
                            IconButton(
                                onPressed: removeOrgmember,
                                icon: const Icon(Icons.close,
                                    color: kBackgroundColor))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
