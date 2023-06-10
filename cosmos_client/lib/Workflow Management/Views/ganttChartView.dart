import 'package:cosmos_client/Workflow%20Management/View%20Cards/ganttChartCard.dart';
import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/stepViewCard.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class GanttChartWorksScreen extends StatefulWidget {
  const GanttChartWorksScreen({Key? key}) : super(key: key);

  @override
  State<GanttChartWorksScreen> createState() => _GanttChartWorksScreenState();
}

class _GanttChartWorksScreenState extends State<GanttChartWorksScreen> {
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
              'Cosmos Project',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(height: 25),
            buildGanttChartView(),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: workcards.length,
                itemBuilder: (context, index) {
                  return GanttChartWorksCard(
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

  Widget buildGanttChartView() {
    return Container(
      child: GanttChartView(
        maxDuration: const Duration(days: 30 * 2),
        startDate: DateTime(2022, 6, 7),
        dayWidth: 30,
        eventHeight: 30,
        stickyAreaWidth: 200,
        showStickyArea: true,
        showDays: true,
        startOfTheWeek: WeekDay.sunday,
        weekEnds: const {WeekDay.friday, WeekDay.saturday},
        isExtraHoliday: (context, day) {
          return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
        },
        events: [
          GanttRelativeEvent(
            relativeToStart: const Duration(days: 0),
            duration: const Duration(days: 5),
            displayName: 'Project Initiation',
          ),
          GanttAbsoluteEvent(
            startDate: DateTime(2022, 6, 10),
            endDate: DateTime(2022, 6, 16),
            displayName: 'Project Planning',
          ),
          GanttAbsoluteEvent(
            startDate: DateTime(2022, 6, 9),
            endDate: DateTime(2022, 6, 16),
            displayName: 'Project Execution',
          ),
          GanttAbsoluteEvent(
            startDate: DateTime(2022, 6, 9),
            endDate: DateTime(2022, 6, 16),
            displayName: 'Project Monitoring',
          ),
        ],
      ),
    );
  }
}
