import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Services/apiserviceworkflow.dart';
import 'package:cosmos_client/Workflow%20Management/View%20Cards/stepViewCard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class StepViewWorksScreen extends StatefulWidget {
  dynamic subworkflow;
  final String workflowName;
  final Function(dynamic) onDelete;
  StepViewWorksScreen(
      {super.key,
      required this.subworkflow,
      required this.workflowName,
      required this.onDelete});

  @override
  State<StepViewWorksScreen> createState() => _StepViewWorksScreenState();
}

class _StepViewWorksScreenState extends State<StepViewWorksScreen> {
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

  //Delete Step view
  deleteStepView() {
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
                    'You want to delete ProgressBar View !',
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
          active: widget.subworkflow['works'][i]['active']));
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
                  );
                  createWork(
                      work_newItem, workcards, widget.subworkflow['_id']);
                  setState(() {
                    workcards.add(work_newItem);
                  });

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.workflowName,
          style: kAppBarTitle,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
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
        onPressed: () => createWorks(context),
        child: const Icon(
          Icons.add,
          color: kDefaultIconLightColor,
        ),
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
                      onPressed: deleteStepView, icon: const Icon(Icons.delete))
                ],
              ),
            ),
            buildStepView(),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: workcards.length,
                itemBuilder: (context, index) {
                  return StepViewWorksCard(
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

  Widget buildStepView() {
    int activeStep = 5; // Initial step set to 5.
    int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

    return Column(
      children: [
        IconStepper(
          // ignore: prefer_const_literals_to_create_immutables
          icons: [
            const Icon(Icons.check),
            const Icon(Icons.flag),
            const Icon(Icons.access_alarm),
            const Icon(Icons.supervised_user_circle),
            const Icon(Icons.flag),
            const Icon(Icons.access_alarm),
            const Icon(Icons.supervised_user_circle),
          ],
          activeStep: activeStep,
          onStepReached: (index) {
            activeStep = index;
          },
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  getHeaderText(activeStep),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getHeaderText(int activeStep) {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Submission --> 2023/05/05';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}

// class StepViewWidget extends StatefulWidget {
//   @override
//   _StepViewWidget createState() => _StepViewWidget();
// }

// class _StepViewWidget extends State<StepViewWidget> {
//   // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
//   int activeStep = 5; // Initial step set to 5.

//   int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               IconStepper(
//                 icons: [
//                   Icon(Icons.supervised_user_circle),
//                   Icon(Icons.flag),
//                   Icon(Icons.access_alarm),
//                   Icon(Icons.supervised_user_circle),
//                   Icon(Icons.flag),
//                   Icon(Icons.access_alarm),
//                   Icon(Icons.supervised_user_circle),
//                 ],

//                 // activeStep property set to activeStep variable defined above.
//                 activeStep: activeStep,

//                 // This ensures step-tapping updates the activeStep.
//                 onStepReached: (index) {
//                   setState(() {
//                     activeStep = index;
//                   });
//                 },
//               ),
//               header(),
//               // Expanded(
//               //   child: FittedBox(
//               //     child: Center(
//               //       child: Text('$activeStep'),
//               //     ),
//               //   ),
//               // ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     previousButton(),
//               //     nextButton(),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Returns the next button.
//   // Widget nextButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       // Increment activeStep, when the next button is tapped. However, check for upper bound.
//   //       if (activeStep < upperBound) {
//   //         setState(() {
//   //           activeStep++;
//   //         });
//   //       }
//   //     },
//   //     child: Text('Next'),
//   //   );
//   // }

//   /// Returns the previous button.
//   // Widget previousButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
//   //       if (activeStep > 0) {
//   //         setState(() {
//   //           activeStep--;
//   //         });
//   //       }
//   //     },
//   //     child: Text('Prev'),
//   //   );
//   // }

//   /// Returns the header wrapping the header text.
//   Widget header() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.orange,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               headerText(),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Returns the header text based on the activeStep.
//   String headerText() {
//     switch (activeStep) {
//       case 1:
//         return 'Preface';

//       case 2:
//         return 'Table of Contents';

//       case 3:
//         return 'About the Author';

//       case 4:
//         return 'Publisher Information';

//       case 5:
//         return 'Reviews';

//       case 6:
//         return 'Chapters #1';

//       default:
//         return 'Introduction';
//     }
//   }
// }
