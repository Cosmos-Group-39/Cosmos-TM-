import 'dart:convert';

import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Widgets/Const_Texts.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Widgets/workflowCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

List<dynamic> wfcards = [];
var uuid = const Uuid();

class CreatedWorkflows extends StatefulWidget {
  final dynamic workflow;
  const CreatedWorkflows({Key? key, this.workflow}) : super(key: key);

  @override
  State<CreatedWorkflows> createState() => _CreatedWorkflowsState(workflow);
}

class _CreatedWorkflowsState extends State<CreatedWorkflows> {
  final dynamic workflow;

  _CreatedWorkflowsState(this.workflow);

  @override
  void initState() {
    super.initState();
    FlutterSecureStorage().read(key: 'userID').then((userID) {
      final options = Options(
        method: 'GET',
        headers: {
          'Authorization': 'Bearer $userID',
        },
      );
      Dio().get('$baseUrls/user/ownWorkflows', options: options).then((value) {
        setState(() {
          wfcards = value.data.map((workflow) => WorkflowModel.fromJson(workflow)).toList();
        });
      });
    });
  }

  //Edit workflow Name
  void wfeditCard(WorkflowModel wfeditedItem) {
    setState(() {
      int index = wfcards.indexWhere((item) => item.wid == wfeditedItem.wid);
      if (index != -1) {
        wfcards[index].title = wfeditedItem.title;
      }
    });
  }

  //delete a card
  void wfdeleteCard(String wid) {
    setState(() {
      wfcards.removeWhere((item) => item.wid == wid);
    });
  }

  String? selectedValue;
  handleRadioValueChange(String? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  //filter workflows
  showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0), side: const BorderSide(color: kPrimaryColor, width: 5)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Sort By',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.3,
                      wordSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.sort,
                  color: Colors.green,
                  size: 70,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RadioListTile<String>(
                      title: const Text('Name (A-Z)'),
                      value: 'Name (A-Z)',
                      groupValue: selectedValue,
                      onChanged: handleRadioValueChange,
                    ),
                    RadioListTile<String>(
                      title: const Text('Name (z-a)'),
                      value: 'Name (Z-A)',
                      groupValue: selectedValue,
                      onChanged: handleRadioValueChange,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        switch (selectedValue) {
                          case 'Name (A-Z)':
                            setState(() {
                              wfcards.sort((a, b) => a.title.compareTo(b.title));
                            });
                            break;
                          case 'Name (Z-A)':
                            setState(() {
                              wfcards.sort((a, b) => b.title.compareTo(a.title));
                            });
                            break;

                          default:
                            // Apply default filter logic
                            break;
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Created Workflows',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 1.3,
              wordSpacing: 1.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(2, 2),
                  blurRadius: 2,
                ),
              ],
            )),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewWorkflowScreen()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      bottomSheet: Container(
        height: 50,
        color: kPrimaryColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Center(
                child: WorkflowCreatedText(context),
              ),
              const Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Divider(thickness: 10),
                  const SizedBox(width: 160),
                  Text(
                    (selectedValue ?? 'Filter Workflows'),
                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: showFilterDialog,
                    icon: const Icon(Icons.filter_alt),
                    color: Colors.blue,
                  )
                ],
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                child: Column(
                    children: wfcards
                        .map(
                          (item) => WorkflowCard(
                            item: item,
                            wfonEdit: wfeditCard,
                            wfonDelete: wfdeleteCard,
                          ),
                        )
                        .toList()),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
