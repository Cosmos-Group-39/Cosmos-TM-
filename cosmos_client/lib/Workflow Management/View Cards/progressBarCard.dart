import 'package:flutter/material.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:intl/intl.dart';

class ProgressBarWorksCard extends StatefulWidget {
  final Function(WorkModel) workonEdit;
  final Function(String) workonDelete;
  final WorkModel item;

  const ProgressBarWorksCard({
    Key? key,
    required this.item,
    required this.workonDelete,
    required this.workonEdit,
  }) : super(key: key);

  @override
  State<ProgressBarWorksCard> createState() => _ProgressBarWorksCardState();
}

class _ProgressBarWorksCardState extends State<ProgressBarWorksCard> {
  TextEditingController _worktitleController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _worktitleController.text = widget.item.title;
  }

  @override
  void dispose() {
    _worktitleController.dispose();
    super.dispose();
  }

  void workeditCard() {
    String title = _worktitleController.text.trim();

    WorkModel work_editedItem = WorkModel(
      workid: widget.item.workid,
      title: title,
      active: true,
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
                // IsActive
                SwitchListTile(
                  title: const Text('Active'),
                  value: isActive,
                  onChanged: (bool value) {
                    print(value);
                    setState(() {
                      isActive = value;
                    });
                  },
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  widget.item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                  ),
                ),
              ),
              SizedBox(width: 60),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: kBackgroundColor),
                  onPressed: () => changeWorkCard(),
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: kBackgroundColor),
                  onPressed: () => deleteWorks(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
