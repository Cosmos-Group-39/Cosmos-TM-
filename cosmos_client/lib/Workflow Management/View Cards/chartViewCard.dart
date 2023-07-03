import 'package:flutter/material.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:intl/intl.dart';

class ChartViewWorksCard extends StatefulWidget {
  final Function(WorkModel) workonEdit;
  final Function(String) workonDelete;
  final WorkModel item;

  const ChartViewWorksCard({
    Key? key,
    required this.item,
    required this.workonDelete,
    required this.workonEdit,
  }) : super(key: key);

  @override
  State<ChartViewWorksCard> createState() => _ChartViewWorksCardState();
}

class _ChartViewWorksCardState extends State<ChartViewWorksCard> {
  TextEditingController _worktitleController = TextEditingController();
  TextEditingController _workDescriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  String? selectedUnit;
  bool isActive = false;

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
                //Work Name
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
        active: true,
        repetitive: RepetitiveModel(
            amount: double.parse(_amountController.text),
            unit: selectedUnit ?? 'NU'));

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
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
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
