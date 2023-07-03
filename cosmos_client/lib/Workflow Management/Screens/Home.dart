import 'dart:convert';

import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Widgets/Drawer.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_client/UserManagement/Screens/SignUp.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/swipeScreen.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchTextController = TextEditingController();
  String errorMessage = '';
  String userName = 'Anonymous';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    FlutterSecureStorage().read(key: 'userName').then((userName) {
      setState(() {
        this.userName = userName ?? 'Anonymous';
      });
    });
    FlutterSecureStorage().read(key: 'userEmail').then((userEmail) {
      setState(() {
        this.userEmail = userEmail ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        drawer: kDrawer(context, userName, userEmail),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.blue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    'images/cosmos.png',
                    height: 200,
                    width: 200,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                workflowsSearch(),
                const SizedBox(height: 2),
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    minimumSize: const Size(150, 50),
                    shadowColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    if (_searchTextController.text.isEmpty) {
                      setState(() {
                        errorMessage = 'Please enter a value';
                      });
                      return;
                    }
                    Dio()
                        .get(
                            '$baseUrls/accesscode/${_searchTextController.text}')
                        .then((value) {
                      // print(jsonDecode(value.data));
                      // print(value.data);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SwipeScreen(workflow: value.data)));
                    }).catchError((value) {
                      setState(() {
                        errorMessage = 'Invalid Access Code';
                      });
                      // print(value);
                    });
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(thickness: 2),
                const SizedBox(height: 50),
                const Text(
                  'Create Workflow',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewWorkflowScreen()));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(100, 50),
                        shadowColor: Colors.black,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(100, 50),
                        shadowColor: Colors.black,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget workflowsSearch() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 45, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: TextField(
              controller: _searchTextController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '    Access Code..',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // //Access Code Validations
  // bool _validate() {
  //   setState(() {
  //     errorText = ''; // Clear the error text initially
  //   });
  //   if (enteredText.isEmpty) {
  //     setState(() {
  //       errorText = 'Access code is required.';
  //     });
  //     return false;
  //   }

  //   return true;
  // }
}
