import 'package:cosmos_client/Templates/Screens/LiveTracking.dart';
import 'package:cosmos_client/UserManagement/Screens/SignUp.dart';
import 'package:cosmos_client/welcomeScreen.dart';
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
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CosmosTM(),
    );
  }
}
