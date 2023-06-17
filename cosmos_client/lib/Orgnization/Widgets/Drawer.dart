import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Form.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Widget kDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      width: 250,
      color: kPrimaryColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            DrawerHeader(
              child: Image.asset(
                'images/cosmos.png',
                height: 150,
                width: 150,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 60),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OrgSettings())),
              leading: const Icon(
                Icons.account_circle_rounded,
              ),
              title: const Text(
                'Your Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.home, color: kBackgroundColor),
              title: Text(
                'Home',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.timeline_rounded, color: kBackgroundColor),
              title: Text(
                'Workflows',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.add, color: kBackgroundColor),
              title: Text(
                'Create Workflows',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.people, color: kBackgroundColor),
              title: Text(
                'Organizations',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.payment, color: kBackgroundColor),
              title: Text(
                'Payments',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.settings, color: kBackgroundColor),
              title: Text(
                'Your Profile',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.tips_and_updates, color: kBackgroundColor),
              title: Text(
                'Help & Tips',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: kBackgroundColor.withOpacity(0.5)),
            const SizedBox(height: 50),
            const ListTile(
              leading: Icon(Icons.logout, color: kDefaultIconLightColor),
              title: Text(
                'Log out',
                style: TextStyle(
                  color: kBackgroundColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
