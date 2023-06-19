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
  List<WorkModel> workcards = [];
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
                  String workid = uuid.v4();
                  WorkModel work_newItem = WorkModel(
                    workid: workid,
                    title: title,
                    active: true,
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

  void deleteWorks(String workid) {
    setState(() {
      workcards.removeWhere((element) => element.workid == workid);
    });
  }

  void editWorks(WorkModel editedItem) {
    setState(() {
      int index = workcards
          .indexWhere((element) => element.workid == editedItem.workid);
      workcards[index] = editedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // Set the desired radius here
            ),
            child: const Icon(Icons.chat_bubble),
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
            const Text(
              'Cosmos Project',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(height: 25),
            buildGanttChartView(),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: workcards.length,
                itemBuilder: (context, index) {
                  return GanttChartWorksCard(
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
    );
  }

  Widget buildGanttChartView() {
    return Container(
      child: GanttChartView(
        maxDuration: const Duration(days: 30 * 2),
        startDate: DateTime(2022, 6, 7),
        dayWidth: 30,
        eventHeight: 30,
        stickyAreaWidth: 150,
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
