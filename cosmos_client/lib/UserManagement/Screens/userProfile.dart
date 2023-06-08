import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Widgets/userProfilePic.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel userModel;

  const UserProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pemailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _pbirthdayController = TextEditingController();
  TextEditingController _pmobileNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late String userprofilePic;
  bool isPremiumSelected = false;
  late String formattedDob;

  @override
  void initState() {
    super.initState();
    formattedDob =
        widget.userModel.dob.toString(); // Replace with your desired format
  }

  DateTime picked = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('User Profile'),
        centerTitle: true,
        leading: IconButton(onPressed: null, icon: Icon(Icons.menu)),
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
                Text(
                  widget.userModel.name,
                  style: const TextStyle(
                    letterSpacing: 3,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.userModel.email,
                  style: const TextStyle(
                    letterSpacing: 2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
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
                const SizedBox(height: 10),
                const Divider(thickness: 3),
                const SizedBox(height: 20),
                const Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Text Field - Name
                const Text(
                  'Full Name',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: widget.userModel.name,
                    prefixIcon: const Icon(Icons.person),
                    suffixIcon: const Icon(Icons.create),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Text Field - Password
                const Text(
                  'Password',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: widget.userModel.password,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.create),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Text Field - Email
                const Text(
                  'Email',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _pemailController,
                  decoration: InputDecoration(
                    labelText: widget.userModel.email,
                    prefixIcon: const Icon(Icons.email),
                    suffixIcon: const Icon(Icons.create),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Text Field - Mobile Number
                const Text(
                  'Mobile Number',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _pmobileNumberController,
                  decoration: InputDecoration(
                    labelText: widget.userModel.mobile,
                    prefixIcon: const Icon(Icons.phone),
                    suffixIcon: const Icon(Icons.create),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Text Field - Date of Birth
                const Text(
                  'Birthday',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _pbirthdayController,
                  decoration: InputDecoration(
                    labelText: formattedDob,
                    prefixIcon: const Icon(Icons.calendar_month),
                    suffixIcon: const Icon(Icons.create),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Text Field - Address
                const Text(
                  'Address',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: widget.userModel.address,
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon: const Icon(Icons.create),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
