import 'package:flutter/material.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:intl/intl.dart';

class StepViewWorksCard extends StatefulWidget {
  final Function(WorkModel) workonEdit;
  final Function(String) workonDelete;
  final WorkModel item;

  const StepViewWorksCard({
    Key? key,
    required this.item,
    required this.workonDelete,
    required this.workonEdit,
  }) : super(key: key);

  @override
  State<StepViewWorksCard> createState() => _StepViewWorksCardState();
}

class _StepViewWorksCardState extends State<StepViewWorksCard> {
  TextEditingController _worktitleController = TextEditingController();
  TextEditingController _workDescriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  String? selectedUnit;
  // // Start Date
  // DateTime pickedStart = DateTime.now();
  // Future<DateTime?> _selectStartDate(BuildContext context) async {
  //   final DateTime? pickedStart = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );

  //   return pickedStart;
  // }

  // // End Date
  // DateTime pickedEnd = DateTime.now();
  // Future<DateTime?> _selectEndDate(BuildContext context) async {
  //   final DateTime? pickedEnd = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );

  //   return pickedEnd;
  // }

  void changeWorkCard() {
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
                  'Update Work',
                  style: kAlertBoxTopicTextStyle,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.edit_document,
                  size: 60.0,
                  color: Colors.green,
                ),
                const SizedBox(height: 10),
                //Work Title
                TextField(
                  controller: _worktitleController,
                  decoration: const InputDecoration(
                    hintText: 'Work Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // //Start Date
                // GestureDetector(
                //   onTap: () async {
                //     pickedStart = (await _selectStartDate(
                //         context))!; // Assign the value to the variable

                //     if (pickedStart != null) {
                //       setState(() {
                //         _startDateController.text =
                //             DateFormat('dd/MM/yyyy').format(pickedStart);
                //       });
                //     }
                //   },
                //   child: AbsorbPointer(
                //     child: TextFormField(
                //       controller: _startDateController,
                //       decoration: const InputDecoration(
                //         labelText: 'Start Date',
                //         prefixIcon: Icon(Icons.edit_calendar),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //         ),
                //       ),
                //       // Validations
                //       validator: (value) {
                //         if (value!.isEmpty) {
                //           return 'Please enter a Start Date';
                //         }

                //         final parts = value.split('/');

                //         if (parts.length != 3) {
                //           return 'Invalid format. Please enter in DD/MM/YYYY format';
                //         }

                //         final day = int.tryParse(parts[0]);
                //         final month = int.tryParse(parts[1]);
                //         final year = int.tryParse(parts[2]);
                //         final currentYear = DateTime.now().year;

                //         if (day == null || month == null || year == null) {
                //           return 'Invalid format';
                //         }

                //         if (year > currentYear) {
                //           return 'Enter a valid year';
                //         }

                //         if (month < 1 || month > 12) {
                //           return 'Enter a valid month';
                //         }

                //         final daysInMonth = DateTime(year, month + 1, 0).day;

                //         if (day < 1 || day > daysInMonth) {
                //           return 'Enter a valid date';
                //         }

                //         return null;
                //       },
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15),
                // //End Date
                // GestureDetector(
                //   onTap: () async {
                //     pickedEnd = (await _selectEndDate(
                //         context))!; // Assign the value to the variable

                //     if (pickedEnd != null) {
                //       setState(() {
                //         _endDateController.text =
                //             DateFormat('dd/MM/yyyy').format(pickedEnd);
                //       });
                //     }
                //   },
                //   child: AbsorbPointer(
                //     child: TextFormField(
                //       controller: _endDateController,
                //       decoration: const InputDecoration(
                //         labelText: 'End Date',
                //         prefixIcon: Icon(Icons.edit_calendar),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //         ),
                //       ),
                //       // Validations
                //       validator: (value) {
                //         if (value!.isEmpty) {
                //           return 'Please enter a Start Date';
                //         }

                //         final parts = value.split('/');

                //         if (parts.length != 3) {
                //           return 'Invalid format. Please enter in DD/MM/YYYY format';
                //         }

                //         final day = int.tryParse(parts[0]);
                //         final month = int.tryParse(parts[1]);
                //         final year = int.tryParse(parts[2]);
                //         final currentYear = DateTime.now().year;

                //         if (day == null || month == null || year == null) {
                //           return 'Invalid format';
                //         }

                //         if (year > currentYear) {
                //           return 'Enter a valid year';
                //         }

                //         if (month < 1 || month > 12) {
                //           return 'Enter a valid month';
                //         }

                //         final daysInMonth = DateTime(year, month + 1, 0).day;

                //         if (day < 1 || day > daysInMonth) {
                //           return 'Enter a valid date';
                //         }

                //         return null;
                //       },
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  workeditCard();
                  Navigator.pop(context);
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

  // Edit Work Description
  editWorkDescription() {
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
                  controller: _workDescriptionController,
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
    _worktitleController.text = widget.item.title;
    _workDescriptionController.text = widget.item.description ?? '';
  }

  @override
  void dispose() {
    _worktitleController.dispose();
    _workDescriptionController.dispose();
    super.dispose();
  }

  void workeditCard() {
    String title = _worktitleController.text.trim();
    String description = _workDescriptionController.text.trim();

    WorkModel work_editedItem = WorkModel(
      workid: widget.item.workid,
      title: title,
      description: description,
      active: widget.item.active,
    );

    widget.workonEdit(work_editedItem);
  }

  void deleteWorks() {
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
                    'You want to delete the Work !',
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  widget.workonDelete(widget.item.workid!);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
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
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: null, // works card on tap
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: kPrimaryColor,
          ),
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 25,
            right: 25,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 2),
                  Container(
                    width: 160,
                    child: Column(
                      children: [
                        Text(
                          widget.item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kBackgroundColor,
                          ),
                        ),
                        Text('data')
                      ],
                    ),
                  ),
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: widget.item.active,
                      onChanged: (bool value) {
                        setState(() {
                          widget.item.active = value;
                        });
                        workeditCard();
                        print(widget.item.active);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.help, color: kDefaultIconLightColor),
                    onPressed: () => editWorkDescription(), // Show Description
                  ),
                  PopupMenuButton<bool>(
                    // onSelected: (bool value) {
                    //   // setState(() {
                    //   //   // Update the member role
                    //   //   isAdmin = value;
                    //   //   widget.member.isAdmin = value;
                    //   // });
                    // },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<bool>>[
                        PopupMenuItem<bool>(
                          value: false,
                          child: TextButton(
                            child: const Text('Edit'),
                            onPressed: () => changeWorkCard(),
                          ),
                        ),
                        PopupMenuItem<bool>(
                          value: true,
                          child: TextButton(
                            child: const Text('Delete'),
                            onPressed: () => deleteWorks(),
                          ),
                        ),
                      ];
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: kBackgroundColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
