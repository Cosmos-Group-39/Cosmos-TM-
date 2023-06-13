import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_MembersAdd.dart';
import 'package:cosmos_client/Orgnization/Models/orgModels.dart';
import 'package:flutter/material.dart';

class OrgPro extends StatefulWidget {
  final OrganizationModel item;
  // final Function(File?) onProfilePicChanged;
  const OrgPro({Key? key, required this.item}) : super(key: key);

  @override
  State<OrgPro> createState() => _OrgProState();
}

class _OrgProState extends State<OrgPro> {
  File? _profilePic;
  List<String> _reviews = [
    'review 1',
    'review 2',
    'review 3',
    'review 4',
    'review 5',
  ];

  @override
  void initState() {
    super.initState();
    _profilePic = File(widget.item.profilePic);
  }

  // void delOrg() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Icon(
  //           Icons.warning_amber_sharp,
  //           size: 60.0,
  //           color: Colors.deepOrange,
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: const [
  //             Text(
  //               'Are You Sure ?',
  //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 17),
  //               child: Text(
  //                 'You want to delete this Organization !',
  //                 style: TextStyle(fontSize: 13),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               cardsx.remove(widget.item.cardID);
  //               print(widget.item.cardName);
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Delete'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            widget.item.cardName,
            style: kAppBarTitle,
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: null,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      _profilePic != null ? FileImage(_profilePic!) : null,
                ),
                const SizedBox(height: 20),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrgAddMembers()));
                      },
                      icon: const Icon(Icons.add_circle),
                      label: const Text('Add Members'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Create Workflows'),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                const Text('Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    )),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(widget.item.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    )),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: _reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_reviews[index]),
                        onTap: () {},
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
