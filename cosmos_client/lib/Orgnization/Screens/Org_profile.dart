import 'dart:io';
import 'package:cosmos_ran/Constants.dart';
import 'package:cosmos_ran/Orgnization/Screens/Org_MembersAdd.dart';
import 'package:cosmos_ran/Orgnization/Screens/Your_Org.dart';
import 'package:cosmos_ran/Orgnization/Utils/FormValidation.dart';
import 'package:cosmos_ran/Orgnization/Widgets/Profile_Pic.dart';
import 'package:flutter/material.dart';

class OrgPro extends StatefulWidget {
  final FormModel item;
  // final Function(File?) onProfilePicChanged;
  const OrgPro({Key? key, required this.item}) : super(key: key);

  @override
  State<OrgPro> createState() => _OrgProState();
}

class _OrgProState extends State<OrgPro> {
  File? _profilePic;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(widget.item.cardName),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(widget.item.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
