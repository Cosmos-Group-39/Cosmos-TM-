import 'package:cosmos_client/Constants.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              padding: EdgeInsets.only(top: 15, bottom: 10, left: 15),
              child: Text(
                'Help & Tips',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor),
              ),
            ),
            OrganizationQSearch(),
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

  Widget OrganizationQSearch() {
    String searchValue = '';
    final List<String> _suggestions = [
      'How to create an organization ?',
      'How to update an organization ?',
      'How to add members to organization?',
      'Organization',
      'Top Organization',
      'Cosmos help',
      'Workflows in organization',
      'Workflows',
    ];
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 45, bottom: 45, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: null,
        borderRadius: BorderRadius.circular(2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: EasySearchBar(
          title: const Text(
            'Search For Help...',
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.white54,
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions),
    );
  }
}
