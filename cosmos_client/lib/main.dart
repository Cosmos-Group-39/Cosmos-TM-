import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Form.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_HomePage.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_MembersAdd.dart';
import 'package:cosmos_client/Orgnization/Screens/Your_Org.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
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
        home: OrgMain());
  }
}
