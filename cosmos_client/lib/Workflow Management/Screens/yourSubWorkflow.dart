import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Widgets/Const_Texts.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Widgets/subworkflowCard.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

List<SubWorkflowModel> subwfcards = [];
var uuid = const Uuid();

class CreatedSubWorkflows extends StatefulWidget {
  const CreatedSubWorkflows({Key? key}) : super(key: key);

  @override
  State<CreatedSubWorkflows> createState() => _CreatedSubWorkflowsState();
}

class _CreatedSubWorkflowsState extends State<CreatedSubWorkflows> {
  @override
  void initState() {
    super.initState();
  }

  //Edit sub workflow Name
  void subwfeditCard(SubWorkflowModel subwf_editedItem) {
    setState(() {
      int index =
          subwfcards.indexWhere((item) => item.swid == subwf_editedItem.swid);
      if (index != -1) {
        subwfcards[index].title = subwf_editedItem.title;
      }
    });
  }

  //delete a sub workflow card
  void subwfdeleteCard(String swid) {
    setState(() {
      subwfcards.removeWhere((item) => item.swid == swid);
    });
  }

  String? selectedValue;
  handleRadioValueChange(String? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  //filter workflows
  // showFilterDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         child: Container(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Center(
  //                 child: Text(
  //                   'Sort By',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               const Icon(
  //                 Icons.sort,
  //                 color: Colors.red,
  //                 size: 70,
  //               ),
  //               const SizedBox(height: 10),
  //               const Divider(thickness: 2),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   RadioListTile<String>(
  //                     title: const Text('Name (A-Z)'),
  //                     value: 'Name (A-Z)',
  //                     groupValue: selectedValue,
  //                     onChanged: handleRadioValueChange,
  //                   ),
  //                   RadioListTile<String>(
  //                     title: const Text('Name (z-a)'),
  //                     value: 'Name (Z-A)',
  //                     groupValue: selectedValue,
  //                     onChanged: handleRadioValueChange,
  //                   ),
  //                   RadioListTile<String>(
  //                     title: const Text('Workflows (max-min)'),
  //                     value: 'No of Workflows',
  //                     groupValue: selectedValue,
  //                     onChanged: handleRadioValueChange,
  //                   ),
  //                   RadioListTile<String>(
  //                     title: const Text('Members (max-min)'),
  //                     value: 'No of Members',
  //                     groupValue: selectedValue,
  //                     onChanged: handleRadioValueChange,
  //                   ),
  //                   RadioListTile<String>(
  //                     title: const Text('Default'),
  //                     value: 'Filter Organization',
  //                     groupValue: selectedValue,
  //                     onChanged: handleRadioValueChange,
  //                   ),
  //                   const SizedBox(height: 16),
  //                 ],
  //               ),
  //               const Divider(thickness: 2),
  //               const SizedBox(height: 10),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () {
  //                       switch (selectedValue) {
  //                         case 'Name (A-Z)':
  //                           setState(() {
  //                             cardsx.sort(
  //                                 (a, b) => a.cardName.compareTo(b.cardName));
  //                           });
  //                           break;
  //                         case 'Name (Z-A)':
  //                           setState(() {
  //                             cardsx.sort(
  //                                 (a, b) => b.cardName.compareTo(a.cardName));
  //                           });
  //                           break;
  //                         case 'No of Workflows':
  //                           // setState(() {
  //                           //   cardsx.sort((a, b) => b.workflows.length
  //                           //       .compareTo(a.workflows.length));
  //                           // });
  //                           break;
  //                         case 'No of Members':
  //                           // Logic for 'Opt3'
  //                           break;
  //                         case 'Filter Organization':
  //                           break;
  //                         default:
  //                           // Apply default filter logic
  //                           break;
  //                       }
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: const Text('Apply'),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   TextButton(
  //                     onPressed: () {
  //                       // Close the dialog without applying the filter
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: const Text('Cancel'),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Created Workflows'),
        centerTitle: true,
        leading: IconButton(
            //pop screen
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatedWorkflows()));
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
                child: orgCreatedText(context),
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(thickness: 10),
                  SizedBox(width: 160),
                  // Text(
                  //   (selectedValue ?? 'Filter Organizations'),
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.w500, color: Colors.blue),
                  // ),
                  // IconButton(
                  //   onPressed: showFilterDialog,
                  //   icon: const Icon(Icons.filter_alt),
                  //   color: Colors.blue,
                  // )
                ],
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                child: Column(
                  children: subwfcards
                      .map((item) => SubWorkflowCard(
                            item: item,
                            subwfonEdit: subwfeditCard,
                            subwfonDelete: subwfdeleteCard,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
