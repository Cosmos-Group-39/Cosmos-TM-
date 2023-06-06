import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

Widget kDrawer() {
  return Drawer(
    child: Container(
      width: 250,
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const FlutterLogo(size: 60),
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Your Profile',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.account_circle_rounded, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Home',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.home, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Workflows',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.timeline_rounded, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Create Workflows',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.add, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Organizations',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.people, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Payments',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.payment, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Your Profile',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.settings, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: [
                Text('Help & Tips',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.tips_and_updates, color: kBackgroundColor),
              ],
            ),
          ),
          Divider(color: kBackgroundColor.withOpacity(0.5)),
          const SizedBox(height: 150),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 90, right: 30),
            child: Row(
              children: [
                Text('Log out',
                    style: TextStyle(
                        color: kBackgroundColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.logout, color: kBackgroundColor),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
