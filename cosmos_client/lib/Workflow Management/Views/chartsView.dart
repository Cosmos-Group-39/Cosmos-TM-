import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Services/apiserviceworkflow.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/chartViewCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/PieChartCard.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:intl/intl.dart';
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
  List<List<double>> dataRows = [];
  List<String> xUserLabels = [];
  List<String> dataRowsLegends = [];

  List<WorkModel> workcards = [];
  Uuid uuid = const Uuid();
  TextEditingController _workController = TextEditingController(); //name
  TextEditingController _workDesController = TextEditingController(); //des
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController =
      TextEditingController(); // Subworkflow
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  String? selectedUnit;
  bool isActive = false;
  // Start Date
  DateTime pickedStart = DateTime.now();
  Future<DateTime?> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStart = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return pickedStart;
  }

  // End Date
  DateTime pickedEnd = DateTime.now();
  Future<DateTime?> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEnd = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return pickedEnd;
  }

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

  // Edit Subworkflow Description
  editSubworkflow() {
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
                  'Description',
                  style: kAlertBoxTopicTextStyle,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.description,
                  size: 60.0,
                  color: Colors.green,
                ),
                const SizedBox(height: 10),
                //SubWorkflow Description
                TextField(
                  maxLines: 3,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Edit here',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  // String title = _workController.text.trim();
                  // String workid = uuid.v4();
                  // WorkModel work_newItem = WorkModel(
                  //   workid: workid,
                  //   title: title,
                  //   active: true,
                  // );
                  // createWork(
                  //     work_newItem, workcards, widget.subworkflow['_id']);
                  // setState(() {
                  //   workcards.add(work_newItem);
                  // });

                  // Navigator.pop(context);
                  // _workController.clear();
                },
                child: const Text(
                  'Confirm',
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

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.subworkflow['title'];
    _descriptionController.text = widget.subworkflow['description'];
    int nWorks = widget.subworkflow['works'].length;
    for (var i = 0; i < nWorks; i++) {
      workcards.add(WorkModel(
        workid: widget.subworkflow['works'][i]['_id'],
        title: widget.subworkflow['works'][i]['title'],
        description: widget.subworkflow['works'][i]['description'],
        active: widget.subworkflow['works'][i]['active'],
        repetitive: RepetitiveModel(
            amount: widget.subworkflow['works'][i]['repetitive']['amount'] ?? 0,
            unit: widget.subworkflow['works'][i]['repetitive']['unit'] ?? 'NU'),
      ));
    }
    createDataArrays();
  }

  createDataArrays() {
    xUserLabels.add(widget.subworkflow['title']);
    for (var work in workcards) {
      dataRows[0].add(work.repetitive?.amount ?? 0);
      dataRowsLegends.add(work.title);
    }
  }

  @override
  void dispose() {
    _workController.dispose();
    _workDesController.dispose();
    super.dispose();
  }

  createWorks(BuildContext context) {
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
                //Work Name
                TextField(
                  controller: _workController,
                  decoration: const InputDecoration(
                    labelText: 'Work Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Work Description
                TextField(
                  controller: _workDesController,
                  decoration: const InputDecoration(
                    labelText: 'Work Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Start Date
                GestureDetector(
                  onTap: () async {
                    pickedStart = (await _selectStartDate(
                        context))!; // Assign the value to the variable

                    if (pickedStart != null) {
                      setState(() {
                        _startDateController.text =
                            DateFormat('dd/MM/yyyy').format(pickedStart);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _startDateController,
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
                        prefixIcon: Icon(Icons.edit_calendar),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      // Validations
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Start Date';
                        }

                        final parts = value.split('/');

                        if (parts.length != 3) {
                          return 'Invalid format. Please enter in DD/MM/YYYY format';
                        }

                        final day = int.tryParse(parts[0]);
                        final month = int.tryParse(parts[1]);
                        final year = int.tryParse(parts[2]);
                        final currentYear = DateTime.now().year;

                        if (day == null || month == null || year == null) {
                          return 'Invalid format';
                        }

                        if (year > currentYear) {
                          return 'Enter a valid year';
                        }

                        if (month < 1 || month > 12) {
                          return 'Enter a valid month';
                        }

                        final daysInMonth = DateTime(year, month + 1, 0).day;

                        if (day < 1 || day > daysInMonth) {
                          return 'Enter a valid date';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //end Date
                GestureDetector(
                  onTap: () async {
                    pickedEnd = (await _selectEndDate(
                        context))!; // Assign the value to the variable

                    if (pickedEnd != null) {
                      setState(() {
                        _endDateController.text =
                            DateFormat('dd/MM/yyyy').format(pickedEnd);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _endDateController,
                      decoration: const InputDecoration(
                        labelText: 'End Date',
                        prefixIcon: Icon(Icons.edit_calendar),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      // Validations
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Start Date';
                        }

                        final parts = value.split('/');

                        if (parts.length != 3) {
                          return 'Invalid format. Please enter in DD/MM/YYYY format';
                        }

                        final day = int.tryParse(parts[0]);
                        final month = int.tryParse(parts[1]);
                        final year = int.tryParse(parts[2]);
                        final currentYear = DateTime.now().year;

                        if (day == null || month == null || year == null) {
                          return 'Invalid format';
                        }

                        if (year > currentYear) {
                          return 'Enter a valid year';
                        }

                        if (month < 1 || month > 12) {
                          return 'Enter a valid month';
                        }

                        final daysInMonth = DateTime(year, month + 1, 0).day;

                        if (day < 1 || day > daysInMonth) {
                          return 'Enter a valid date';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Amount and unit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 130,
                      child: TextField(
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.shade100,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      child: DropdownButton<String>(
                        underline: Text(''),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        alignment: AlignmentDirectional.centerEnd,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          decoration: null,
                        ),
                        value: selectedUnit,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUnit = newValue;
                          });
                          print(selectedUnit);
                        },
                        items: <String>[
                          'kg',
                          'km',
                          'm',
                          'LKR',
                          'USD',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
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
                  String descripion = _workDesController.text.trim();
                  String workid = uuid.v4();
                  WorkModel work_newItem = WorkModel(
                    workid: workid,
                    title: title,
                    description: descripion,
                    active: true,
                    repetitive: RepetitiveModel(
                        amount: double.parse(_amountController.text),
                        unit: selectedUnit ?? 'NU'),
                  );
                  createWork(
                      work_newItem, workcards, widget.subworkflow['_id']);
                  setState(() {
                    workcards.add(work_newItem);
                  });
                  createDataArrays();
                  Navigator.pop(context);
                  _workController.clear();
                  _workDesController.clear();
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
    deleteWork(workcards.firstWhere((element) => element.workid == workid),
        workcards, widget.subworkflow['_id']);
    setState(() {
      workcards.removeWhere((element) => element.workid == workid);
    });
    dataRows.clear();
    xUserLabels.clear();
    dataRowsLegends.clear();
    createDataArrays();
  }

  void editWorks(WorkModel editedItem) {
    setState(() {
      int index = workcards
          .indexWhere((element) => element.workid == editedItem.workid);
      workcards[index] = editedItem;
    });
    editWork(
        workcards.firstWhere((element) => element.workid == editedItem.workid),
        workcards,
        widget.subworkflow['_id']);
    dataRows.clear();
    xUserLabels.clear();
    dataRowsLegends.clear();
    createDataArrays();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () => createWorks(context),
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
                        icon: const Icon(Icons.help,
                            color: kDefaultIconLightColor),
                        onPressed: editSubworkflow, // Show Description
                      ),
                      IconButton(
                          onPressed: deleteChartView,
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: dataRowsLegends.isEmpty
                          ? const Text('Add a Work')
                          : buildChartWidget(),
                    ),
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
      dataRows: dataRows,
      xUserLabels: xUserLabels,
      dataRowsLegends: dataRowsLegends,
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
