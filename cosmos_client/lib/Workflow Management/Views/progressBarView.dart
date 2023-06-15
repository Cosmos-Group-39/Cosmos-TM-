import 'package:cosmos_client/Workflow%20Management/View%20Cards/progressBarCard.dart';
import 'package:flutter/material.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class ProgressBarWorksScreen extends StatefulWidget {
  const ProgressBarWorksScreen({Key? key}) : super(key: key);

  @override
  State<ProgressBarWorksScreen> createState() => _ProgressBarWorksScreenState();
}

class _ProgressBarWorksScreenState extends State<ProgressBarWorksScreen> {
  List<WorksModel> workcards = [];
  int x = 0;
  Uuid uuid = Uuid();
  TextEditingController _workController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _workController.dispose();
    super.dispose();
  }

  void createWorks() {
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
                  'Create Work',
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
                  controller: _workController,
                  decoration: const InputDecoration(
                    hintText: 'Work Name',
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
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  String title = _workController.text.trim();
                  String wwid = uuid.v4();
                  WorksModel work_newItem = WorksModel(
                    wwid: wwid,
                    title: title,
                  );

                  setState(() {
                    workcards.add(work_newItem);
                  });

                  Navigator.pop(context);
                  _workController.clear();
                },
                child: const Text(
                  'Create',
                  style: kAlertBoxButtonTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void deleteWorks(String wwid) {
    setState(() {
      workcards.removeWhere((element) => element.wwid == wwid);
    });
  }

  void editWorks(WorksModel editedItem) {
    setState(() {
      int index =
          workcards.indexWhere((element) => element.wwid == editedItem.wwid);
      workcards[index] = editedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'Works',
            style: kAppBarTitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatedSubWorkflows()));
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupPage(
                              name: '',
                              userId: '',
                            )));
              },
              child: const Icon(Icons.chat_bubble),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the desired radius here
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () => createWorks(),
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Camera Order',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(height: 25),
              progressBarWidget(),
              Expanded(
                child: ListView.builder(
                  itemCount: workcards.length,
                  itemBuilder: (context, index) {
                    return ProgressBarWorksCard(
                      item: workcards[index],
                      workonDelete: (wwid) => deleteWorks(wwid),
                      workonEdit: (editedItem) => editWorks(editedItem),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  progressBarWidget() {
    double progress = 0.6; // Sample progress value

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 15,
            value: progress,
          ),
          const SizedBox(height: 8.0),
          Text('${(progress * 100).toStringAsFixed(1)}%'),
        ],
      ),
    );
  }
}
