import 'package:flutter/material.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';

class PieChartWorksCard extends StatefulWidget {
  final Function(WorkModel) workonEdit;
  final Function(String) workonDelete;
  final WorkModel item;

  const PieChartWorksCard({
    Key? key,
    required this.item,
    required this.workonDelete,
    required this.workonEdit,
  }) : super(key: key);

  @override
  State<PieChartWorksCard> createState() => _PieChartWorksCardState();
}

class _PieChartWorksCardState extends State<PieChartWorksCard> {
  TextEditingController _worktitleController = TextEditingController();

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
