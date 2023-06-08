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
    OrgMembersModel(memberId: '1', name: 'aaa', role: 'Member'),
    OrgMembersModel(memberId: '2', name: 'aaa bbb', role: 'Admin'),
    OrgMembersModel(memberId: '3', name: 'bbbb ccc', role: 'Member'),
    OrgMembersModel(memberId: '1', name: 'bbb aac', role: 'Member'),
    OrgMembersModel(memberId: '2', name: 'ddrf', role: 'Admin'),
    OrgMembersModel(memberId: '3', name: 'zz ddaa', role: 'Member'),
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
          title: const Text('Add Member'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(member.name),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context); // Close the dialog box
                    selectedMembers.add(member);
                    filteredMembers.remove(member);
                  });
                },
                child: const Text('Add'),
              ),
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
          fontSize: 16,
          wordSpacing: 2,
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
              orgMemberSearch(context, searchMembers, true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Search Results'),
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
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(
                                          context); // Close the dialog box
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
                child: const Text('Search'),
              ),
              ...getDisplayedCards(),
            ],
          ),
        ),
      ),
    );
  }
}
