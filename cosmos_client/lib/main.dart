import 'package:cosmos_client/Orgnization/Screens/Org_HomePage.dart';
import 'package:cosmos_client/Payment/screens/payment_home.dart';
import 'package:cosmos_client/Workflow%20Management/Views/calenderView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/chartsView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/ganttChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/pieChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/progressBarView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/stepView.dart';
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
        home: ChartViewWorksScreen());
  }
}
