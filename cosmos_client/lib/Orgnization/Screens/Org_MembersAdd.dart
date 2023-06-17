import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Models/orgModels.dart';
import 'package:cosmos_client/Orgnization/Widgets/Const_Texts.dart';
import 'package:cosmos_client/Orgnization/Widgets/Members_Search.dart';
import 'package:cosmos_client/Orgnization/Widgets/memberCard.dart';
import 'package:flutter/material.dart';

class OrgAddMembers extends StatefulWidget {
  const OrgAddMembers({Key? key}) : super(key: key);

  @override
  State<OrgAddMembers> createState() => _OrgAddMembersState();
}

class _OrgAddMembersState extends State<OrgAddMembers> {
  List<OrgMembersModel> allMembers = [
    OrgMembersModel(userId: '1', name: 'aaa', isAdmin: false),
    OrgMembersModel(userId: '2', name: 'aaa bbb', isAdmin: false),
    OrgMembersModel(userId: '3', name: 'bbbb ccc', isAdmin: false),
    OrgMembersModel(userId: '1', name: 'bbb aac', isAdmin: false),
    OrgMembersModel(userId: '2', name: 'ddrf', isAdmin: false),
    OrgMembersModel(userId: '3', name: 'zz ddaa', isAdmin: false),
  ];

  List<OrgMembersModel> filteredMembers = [];
  List<OrgMembersModel> selectedMembers = [];

  void searchMembers(String query) {
    setState(() {
      filteredMembers = allMembers
          .where((member) =>
              member.name.toLowerCase().contains(query.toLowerCase()) &&
              !selectedMembers.contains(member))
          .toList();
    });
  }

  void removeMember(OrgMembersModel member) {
    setState(() {
      filteredMembers.add(member);
      selectedMembers.remove(member);
    });
  }

  void addMemberToScreen(OrgMembersModel member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          title: Center(
              child: Text(
            'Add Member',
            style: kAlertBoxTopicTextStyle,
          )),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(thickness: 3),
              const SizedBox(height: 5),
              Text(member.name),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: kAlertBoxButtonStyle, //Elevated button style
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context); // Close the dialog box
                      selectedMembers.add(member);
                      filteredMembers.remove(member);
                    });
                  },
                  child: const Text(
                    'Add',
                    style:
                        kAlertBoxButtonTextStyle, //Elevated button Text style
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }

  void removeSelectedMember(OrgMembersModel member) {
    setState(() {
      selectedMembers.remove(member);
      filteredMembers.add(member);
    });
  }

  List<Widget> getDisplayedCards() {
    List<Widget> memcards = [];
    memcards.add(const SizedBox(height: 20));
    memcards.add(
      const Text(
        'Selected Members',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          wordSpacing: 2,
          letterSpacing: 1.5,
        ),
      ),
    );
    memcards.add(const SizedBox(height: 10));

    for (final member in selectedMembers) {
      memcards.add(
        MemberCardWidget(
          member: member,
          onRemoveMember: () {
            setState(() {
              removeSelectedMember(member);
            });
          },
          onCardPressed: () {},
        ),
      );
    }

    return memcards;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Members',
            style: kAppBarTitle,
          ),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              orgAddMmeberText(context),
              orgMemberSearch(context, searchMembers, true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 45)),
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: kAlertBoxBorderStyle,
                        title: Center(
                          child: Text('Search Results',
                              style: kAlertBoxTopicTextStyle),
                        ),
                        content: Container(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredMembers.length,
                            itemBuilder: (BuildContext context, int index) {
                              final member = filteredMembers[index];
                              return ListTile(
                                title: Text(member.name),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                      addMemberToScreen(member);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Search',
                  style: kAlertBoxButtonTextStyle,
                ),
              ),
              SizedBox(height: 20),
              Divider(thickness: 3),
              SizedBox(height: 5),
              ...getDisplayedCards(),
            ],
          ),
        ),
      ),
    );
  }
}
