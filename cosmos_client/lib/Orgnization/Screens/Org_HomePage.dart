import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Widgets/Const_Texts.dart';
import 'package:cosmos_client/Orgnization/Widgets/Drawer.dart';
import 'package:cosmos_client/Orgnization/Widgets/Org_GridView.dart';
import 'package:cosmos_client/Orgnization/Widgets/Org_SearchBox.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:cosmos_client/UserManagement/Screens/userProfile.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:flutter/material.dart';

class OrgMain extends StatefulWidget {
  const OrgMain({Key? key}) : super(key: key);

  @override
  State<OrgMain> createState() => _OrgMainState();
}

class _OrgMainState extends State<OrgMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: kDrawer(),
      body: SafeArea(
        child: ListView(
          //whole screen.
          children: [
            Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 2, right: 2, bottom: 5),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ],
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: kBackgroundColor),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        const Text(
                          'Organizations',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor,
                              letterSpacing: 1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_sharp,
                              color: kBackgroundColor),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    OrgSearch(),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  orgHomeText(context),
                  const SizedBox(height: 40),
                  orgGridView(context),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        elevation: 10,
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: kDefaultIconLightColor.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  icon: Icon(Icons.home_outlined)),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              activeIcon: Icon(Icons.people_alt),
              label: 'Organizations'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle_sharp),
              label: 'Profile'),
        ],
      ),
    );
  }
}
