import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:cosmos_client/Workflow%20Management/Widgets/subworkflowCard.dart';
import 'package:flutter/material.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class CreatedSubWorkflows extends StatefulWidget {
  const CreatedSubWorkflows({Key? key}) : super(key: key);

  @override
  State<CreatedSubWorkflows> createState() => _CreatedSubWorkflowsState();
}

class _CreatedSubWorkflowsState extends State<CreatedSubWorkflows> {
  List<SubWorkflowModel> subwfcards = [];
  Uuid uuid = Uuid();
  TextEditingController _subwfController = TextEditingController();

  @override
  void dispose() {
    _subwfController.dispose();
    super.dispose();
  }

  void createSubWorkflow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Create Sub Workflow',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.add,
                  size: 60.0,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _subwfController,
                  decoration: const InputDecoration(
                    hintText: 'Sub Workflow Name',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String title = _subwfController.text.trim();
                String swid = uuid.v4();
                SubWorkflowModel subwf_newItem = SubWorkflowModel(
                  swid: swid,
                  title: title,
                );

                setState(() {
                  subwfcards.add(subwf_newItem);
                });

                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void deleteSubWorkflow(String swid) {
    setState(() {
      subwfcards.removeWhere((element) => element.swid == swid);
    });
  }

  void editSubWorkflow(SubWorkflowModel editedItem) {
    setState(() {
      int index =
          subwfcards.indexWhere((element) => element.swid == editedItem.swid);
      subwfcards[index] = editedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Sub Workflows'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatedWorkflows()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => createSubWorkflow(),
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: subwfcards.length,
          itemBuilder: (context, index) {
            return SubWorkflowCard(
              item: subwfcards[index],
              subwfonDelete: (swid) => deleteSubWorkflow(swid),
              subwfonEdit: (editedItem) => editSubWorkflow(editedItem),
            );
          },
        ),
      ),
    );
  }
}
