import 'package:cosmos_client/Workflow%20Management/View%20Cards/chartViewCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/PieChartCard.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class ChartViewWorksScreen extends StatefulWidget {
  dynamic subworkflow;
  final String workflowName;
  final Function(dynamic) onDelete;
  ChartViewWorksScreen(
      {super.key,
      required this.subworkflow,
      required this.workflowName,
      required this.onDelete});

  @override
  State<ChartViewWorksScreen> createState() => _ChartViewWorksScreenState();
}

class _ChartViewWorksScreenState extends State<ChartViewWorksScreen> {
  List<WorkModel> workcards = [];
  Uuid uuid = const Uuid();
  TextEditingController _workController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  //Delete Chart view
  deleteChartView() {
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
                    'You want to delete Chart View !',
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
                    Navigator.pop(context);
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

  //Description Chart view
  editDescription() {
    ;
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.subworkflow['title'];
    _descriptionController.text = widget.subworkflow['description'];
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
                const SizedBox(height: 20),
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
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                      IconButton(
                          onPressed: deleteChartView,
                          icon: const Icon(Icons.delete))
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
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: buildChartWidget()),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: workcards.length,
                    itemBuilder: (context, index) {
                      return ChartViewWorksCard(
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
      ),
    );
  }

  Widget buildChartWidget() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        yTransform: log10,
        yInverseTransform: inverseLog10,
      ),
    );
    chartData = ChartData(
      dataRows: const [
        [10.0, 200.0, 20000.0],
        [70.0, 700.0, 150000.0],
      ],
      xUserLabels: const ['March', 'April', 'May'],
      dataRowsLegends: const [
        'Materials',
        'Workers',
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }
}
