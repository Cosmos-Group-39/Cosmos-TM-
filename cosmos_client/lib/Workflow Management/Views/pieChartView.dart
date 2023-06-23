import 'package:cosmos_client/Workflow%20Management/Services/apiserviceworkflow.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/PieChartCard.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class PieChartWorksScreen extends StatefulWidget {
  dynamic subworkflow;
  final String workflowName;
  final Function(dynamic) onDelete;
  PieChartWorksScreen({super.key, required this.subworkflow, required this.workflowName, required this.onDelete});

  @override
  State<PieChartWorksScreen> createState() => _PieChartWorksScreenState();
}

class _PieChartWorksScreenState extends State<PieChartWorksScreen> {
  List<WorkModel> workcards = [];
  Uuid uuid = const Uuid();
  TextEditingController _workController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  //Delete Pie Chart view
  deletePieChartView() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          title: const Icon(
            Icons.delete,
            size: 60.0,
            color: Colors.green,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are You Sure ?',
                  style: kAlertBoxTopicTextStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 17),
                  child: Text(
                    'You want to delete Pie Chart View !',
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: kAlertBoxButtonStyle,
                  onPressed: () {
                    widget.onDelete(widget.subworkflow);
                  },
                  child: const Text(
                    'Delete',
                    style: kAlertBoxButtonTextStyle,
                  ),
                ),
                ElevatedButton(
                  style: kAlertBoxButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: kAlertBoxButtonTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  //Title Pie Chart view
  editTitle() {
    ;
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.subworkflow['title'];
    _descriptionController.text = widget.subworkflow['description'];
    int nWorks = widget.subworkflow['works'].length;
    for (var i = 0; i < nWorks; i++) {
      workcards.add(WorkModel(
          workid: widget.subworkflow['works'][i]['_id'], title: widget.subworkflow['works'][i]['title'], active: widget.subworkflow['works'][i]['active']));
    }
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
                  String workid = uuid.v4();
                  WorkModel work_newItem = WorkModel(
                    workid: workid,
                    title: title,
                    active: true,
                  );
                  createWork(work_newItem, workcards, widget.subworkflow['_id']);
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

  void deleteWorks(String workid) {
    deleteWork(workcards.firstWhere((element) => element.workid == workid), workcards, widget.subworkflow['_id']);
    setState(() {
      workcards.removeWhere((element) => element.workid == workid);
    });
  }

  void editWorks(WorkModel editedItem) {
    setState(() {
      int index = workcards.indexWhere((element) => element.workid == editedItem.workid);
      workcards[index] = editedItem;
    });
    editWork(workcards.firstWhere((element) => element.workid == editedItem.workid), workcards, widget.subworkflow['_id']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            widget.workflowName,
            style: kAppBarTitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatedSubWorkflows()));
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GroupPage(
                              name: '',
                              userId: '',
                            )));
              },
              child: const Icon(Icons.chat_bubble),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Set the desired radius here
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () => createWorks(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.create),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Title';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(onPressed: deletePieChartView, icon: const Icon(Icons.delete))
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.create),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildPieChart(),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: workcards.length,
                  itemBuilder: (context, index) {
                    return PieChartWorksCard(
                      item: workcards[index],
                      workonDelete: (workid) => deleteWorks(workid),
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

  Widget buildPieChart() {
    final dataMap = <String, double>{
      "Food": 5,
      "Travelling": 4,
      "Rent": 1,
      "Internet and Phone": 2,
    };

    final colorList = <Color>[
      Colors.greenAccent,
      Colors.amber,
      Colors.blue,
      Colors.red,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        ringStrokeWidth: 20,
        colorList: colorList,
        initialAngleInDegree: -90,
        chartLegendSpacing: 48,
        chartRadius: 200,
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: false,
          showChartValuesInPercentage: true,
          decimalPlaces: 1,
        ),
      ),
    );
  }
}
