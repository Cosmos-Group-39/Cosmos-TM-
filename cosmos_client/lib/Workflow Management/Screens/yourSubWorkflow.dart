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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subwfController.dispose();
    super.dispose();
  }

  //Create Sub Workflow
  void createSubWorkflow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create Sub Workflow',
                  style: kAlertBoxTopicTextStyle,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.add,
                  size: 60.0,
                  color: Colors.green,
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle, //Elevated button style
                onPressed: () {
                  String title = _subwfController.text.trim();
                  String subid = uuid.v4();
                  SubWorkflowModel subwf_newItem = SubWorkflowModel(
                    subid: subid,
                    title: title,
                    view: '',
                  );

                  setState(() {
                    subwfcards.add(subwf_newItem);
                  });

                  Navigator.pop(context);
                },
                child: const Text(
                  'Create',
                  style: kAlertBoxButtonTextStyle, //Elevated button Text style
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void deleteSubWorkflow(String subid) {
    setState(() {
      subwfcards.removeWhere((element) => element.subid == subid);
    });
  }

  void editSubWorkflow(SubWorkflowModel editedItem) {
    setState(() {
      int index =
          subwfcards.indexWhere((element) => element.subid == editedItem.subid);
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
