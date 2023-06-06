import 'package:cosmos_ran/Constants.dart';
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
            child: Row(
              children: const [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 90, right: 30),
            child: Row(
              children: const [
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
