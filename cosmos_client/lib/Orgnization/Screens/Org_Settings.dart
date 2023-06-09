import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

class OrgSettings extends StatefulWidget {
  const OrgSettings({Key? key}) : super(key: key);

  @override
  _OrgSettingsState createState() => _OrgSettingsState();
}

class _OrgSettingsState extends State<OrgSettings> {
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Help And Tips'),
        centerTitle: true,
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
                'Help & Tips',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for help...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: kDefaultIconDarkColor.withOpacity(0.2),
              thickness: 2,
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              minLeadingWidth: 50,
              trailing: const Icon(Icons.help, color: kDefaultIconDarkColor),
              title: const Text('Example Questions',
                  style: TextStyle(
                      color: kTextColor, fontWeight: FontWeight.w500)),
              subtitle: const Text('Frequently Asked Questions'),
              onTap: () {},
            ),
            Divider(
              color: kDefaultIconDarkColor.withOpacity(0.2),
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
