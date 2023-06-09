import 'dart:js_util';

import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Widgets/WFSearchBox.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController();

  void searchWorkflows(String searchText) {
    List<Workflow> retrievedWorkflows = [];

    // Navigate to the workflow page with the retrieved workflows
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatedWorkflows(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'Images/CosmosLogo.jpg',
                  height: 200,
                  width: 200,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Enter an access code, Email or Phone number',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              workflowsSearch(context, searchWorkflows),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(200, 50),
                  shadowColor: Colors.black,
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  searchWorkflows(searchTextController.text);
                },
                child: const Icon(Icons.send),
              ),
              const SizedBox(height: 40),
              Divider(thickness: 2),
              const SizedBox(height: 50),
              Text(
                'Create Workflow',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 40),
              FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewWorkflowScreen()));
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
