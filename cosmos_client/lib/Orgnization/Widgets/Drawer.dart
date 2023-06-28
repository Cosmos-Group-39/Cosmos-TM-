import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Form.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_HomePage.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Settings.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_client/UserManagement/Screens/userProfile.dart';
import 'package:cosmos_client/UserManagement/Widgets/userProfilePic.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

logout(BuildContext context) {
  const storage = FlutterSecureStorage();
  storage.delete(key: 'userID');
  storage.delete(key: 'userName');
  storage.delete(key: 'userEmail');
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const HomeScreen()));
}

Widget kDrawer(BuildContext context, String userName, String userEmail) {
  return Drawer(
    backgroundColor: kPrimaryColor,
    child: Container(
      width: 250,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAccountsDrawerHeader(
                onDetailsPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                                userModel: UserModel(
                                    firstName: 'firstName',
                                    lastName: '',
                                    email: '',
                                    mobile: '',
                                    password: '',
                                    dob: DateTime(1999),
                                    isDeleted: true,
                                    subcription: ''),
                              )));
                },
                currentAccountPicture: CircleAvatar(),
                accountName: Text(userName),
                accountEmail: Text(userEmail)),
            const SizedBox(height: 15),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
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
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatedWorkflows())),
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
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewWorkflowScreen())),
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
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OrgMain())),
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
                'Settings',
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
            ListTile(
              onTap: () => logout(context),
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
