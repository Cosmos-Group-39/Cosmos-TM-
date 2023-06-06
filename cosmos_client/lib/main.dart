import 'package:cosmos_ran/Chat/Screen/chat_group.dart';
import 'package:cosmos_ran/Orgnization/Screens/Org_HomePage.dart';
import 'package:cosmos_ran/UserManagement/Screens/LogInOTP.dart';
import 'package:cosmos_ran/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_ran/UserManagement/Screens/SignUp.dart';
import 'package:cosmos_ran/Workflow%20Management/Screens/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cosmos(TM)',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SignupScreen());
  }
}
