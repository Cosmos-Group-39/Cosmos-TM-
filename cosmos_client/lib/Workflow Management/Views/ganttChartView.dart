import 'package:cosmos_client/Workflow%20Management/Services/apiserviceworkflow.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/ganttChartCard.dart';
import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/stepViewCard.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GanttChartWorksScreen extends StatefulWidget {
  dynamic subworkflow;
  final String workflowName;
  final Function(dynamic) onDelete;
  GanttChartWorksScreen(
      {super.key,
      required this.subworkflow,
      required this.workflowName,
      required this.onDelete});

  @override
  State<GanttChartWorksScreen> createState() => _GanttChartWorksScreenState();
}

class _GanttChartWorksScreenState extends State<GanttChartWorksScreen> {
  List<GanttEventBase> tasks = [];
  List<WorkModel> workcards = [];
  Uuid uuid = Uuid();
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

  //Delete Gantt Chart view
  deleteGanttChartView() {
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
                    'You want to delete Gantt Chart View !',
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
        startTime: DateTime.parse(widget.subworkflow['works'][i]['startTime']),
        endTime: DateTime.parse(widget.subworkflow['works'][i]['endTime']),
      ));
    }
    createTaskArrays();
  }

  createTaskArrays() {
    tasks.clear();
    for (var work in workcards) {
      tasks.add(
        GanttAbsoluteEvent(
          startDate: work.startTime ?? DateTime.now(),
          endDate: work.endTime ?? DateTime.now(),
          displayName: work.title,
        ),
      );
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
                    startTime: pickedStart,
                    endTime: pickedEnd,
                  );
                  createWork(
                      work_newItem, workcards, widget.subworkflow['_id']);
                  setState(() {
                    workcards.add(work_newItem);
                  });
                  createTaskArrays();
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
    createTaskArrays();
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
    createTaskArrays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => createWorks(context),
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
                  IconButton(
                    icon: const Icon(Icons.help, color: kDefaultIconDarkColor),
                    onPressed: editSubworkflow, // Show Description
                  ),
                  IconButton(
                      onPressed: deleteGanttChartView,
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 20),
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
          startDate: DateTime(2023, 6, 1),
          dayWidth: 30,
          eventHeight: 30,
          stickyAreaWidth: 150,
          showStickyArea: true,
          showDays: true,
          startOfTheWeek: WeekDay.monday,
          weekEnds: const {},
          events: tasks),
    );
  }
}
