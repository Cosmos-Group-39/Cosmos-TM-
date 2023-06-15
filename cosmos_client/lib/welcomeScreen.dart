import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CosmosTM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'images/cosmos.png', // Replace with the actual image file name and extension
                  width: 300,
                  height: 300,
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  backgroundColor: kPrimaryColor,
                  elevation: 10,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Center(
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
