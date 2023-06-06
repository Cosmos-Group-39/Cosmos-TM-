import 'package:cosmos_ran/Constants.dart';
import 'package:flutter/material.dart';

class OrgSettings extends StatefulWidget {
  const OrgSettings({Key? key}) : super(key: key);

  @override
  _OrgSettingsState createState() => _OrgSettingsState();
}

class _OrgSettingsState extends State<OrgSettings> {
  //Dialog boxes
  delOrg() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.warning_amber_sharp,
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
                  'You want to delete your all Organizations !',
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
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  saveChanges() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.assignment_sharp,
            size: 60.0,
            color: Colors.blueAccent,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Save changes ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 17),
                child: Text(
                  'Your unsaved changes will be lost.\n  Save changes before closing ?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Settings'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.save), onPressed: saveChanges),
        ],
      ),
      body: Container(
        color: kBackgroundColor,
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 40, left: 15),
              child: Text(
                'Genaral Settings',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              minLeadingWidth: 50,
              trailing: const Icon(Icons.create_rounded,
                  color: kDefaultIconDarkColor),
              title: const Text('Members',
                  style: TextStyle(
                      color: kTextColor, fontWeight: FontWeight.w500)),
              subtitle:
                  Text('Add/Remove', style: TextStyle(color: Colors.grey[500])),
              onTap: () {},
            ),
            Divider(
                color: kDefaultIconDarkColor.withOpacity(0.2), thickness: 2),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              minLeadingWidth: 50,
              trailing:
                  const Icon(Icons.notifications, color: kDefaultIconDarkColor),
              title: const Text('Notifications',
                  style: TextStyle(
                      color: kTextColor, fontWeight: FontWeight.w500)),
              subtitle: Text('Notifications setting',
                  style: TextStyle(color: Colors.grey[500])),
              onTap: () {},
            ),
            Divider(
                color: kDefaultIconDarkColor.withOpacity(0.2), thickness: 2),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              minLeadingWidth: 50,
              trailing: const Icon(Icons.tips_and_updates,
                  color: kDefaultIconDarkColor),
              title: const Text('Help and Tips',
                  style: TextStyle(
                      color: kTextColor, fontWeight: FontWeight.w500)),
              subtitle: Text('Contact us, Privacy Policy',
                  style: TextStyle(color: Colors.grey[500])),
              onTap: () {},
            ),
            Divider(
                color: kDefaultIconDarkColor.withOpacity(0.2), thickness: 2),
            ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                minLeadingWidth: 50,
                trailing:
                    const Icon(Icons.delete, color: kDefaultIconDarkColor),
                title: const Text('Delete Organizations',
                    style: TextStyle(
                        color: kTextColor, fontWeight: FontWeight.w500)),
                subtitle: Text('Delete all organizations',
                    style: TextStyle(color: Colors.grey[500])),
                onTap: delOrg),
            Divider(
                color: kDefaultIconDarkColor.withOpacity(0.2), thickness: 2),
          ],
        ),
      ),
    );
  }
}
