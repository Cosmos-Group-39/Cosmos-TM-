import 'package:cosmos_client/Orgnization/Screens/Org_Form.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/swipeScreen.dart';
import 'package:cosmos_client/color.schemes.g.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmos(TM)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: HomeScreen(),
    );
  }
}
