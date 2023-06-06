import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Widgets/userProfilePic.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel userModel;
  // final Function(File?) onProfilePicChanged;
  const UserProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String userprofilePic;
  bool ispremiumSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: null,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Center(
                  child: UserProfilePictureWidget(
                    onImageSelected: (String? imagePath) {
                      setState(() {
                        userprofilePic = imagePath ?? '';
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '_Name_',
                  style: TextStyle(
                      letterSpacing: 3,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
                const SizedBox(height: 10),
                const Text(
                  '_Email_',
                  style: TextStyle(
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    fixedSize: MaterialStateProperty.all<Size>(Size(150, 50)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: null,
                  child: const Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
