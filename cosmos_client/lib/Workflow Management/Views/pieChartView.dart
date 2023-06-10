import 'package:cosmos_client/Workflow%20Management/View%20Cards/PieChartCard.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class PieChartWorksScreen extends StatefulWidget {
  const PieChartWorksScreen({Key? key}) : super(key: key);

  @override
  State<PieChartWorksScreen> createState() => _PieChartWorksScreenState();
}

class _PieChartWorksScreenState extends State<PieChartWorksScreen> {
  List<WorksModel> workcards = [];
  int x = 0;
  Uuid uuid = const Uuid();
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Create Work',
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
            TextButton(
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
              child: const Text('Create'),
            ),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Works'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatedSubWorkflows()));
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
            Text(
              'Daily Expenses',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 40),
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
                    workonDelete: (wwid) => deleteWorks(wwid),
                    workonEdit: (editedItem) => editWorks(editedItem),
                  );
                },
              ),
            ),
          ],
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
