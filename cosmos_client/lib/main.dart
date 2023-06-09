import 'package:cosmos_client/FeedBack/Screens/feedbackReview.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_HomePage.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_client/UserManagement/Screens/SignUp.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorksWorkflows.dart';
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
        home: HomeScreen());
  }
}
