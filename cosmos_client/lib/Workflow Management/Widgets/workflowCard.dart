import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:flutter/material.dart';

class WorkflowCard extends StatefulWidget {
  final Function(WorkflowModel) wfonEdit;
  final Function(String) wfonDelete;
  final WorkflowModel item;

  const WorkflowCard({
    Key? key,
    required this.item,
    required this.wfonDelete,
    required this.wfonEdit,
  }) : super(key: key);

  @override
  State<WorkflowCard> createState() => _WorkflowCardState();
}

class _WorkflowCardState extends State<WorkflowCard> {
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void wfeditCard() {
    String title = _titleController.text.trim();

    WorkflowModel wfeditedItem = WorkflowModel(
      wid: widget.item.wid,
      title: title,
    );

    widget.wfonEdit(wfeditedItem);
  }

  //Delete Organization
  deleteWorkflow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.delete,
            size: 60.0,
            color: Colors.deepOrange,
          ),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are You Sure ?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 17),
                  child: Text(
                    'You want to delete the Workflow !',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.wfonDelete(widget.item.wid);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  //Update Card
  changeCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Update Workflow',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.edit_document,
                  size: 60.0,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Workflow Name',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                wfeditCard();
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => OrgPro(
        //       item: FormModel(
        //         cardID: uuid.v1(),
        //         cardName: widget.item.cardName,
        //         description: widget.item.description,
        //         profilePic: widget.item.profilePic,
        //       ),
        //     ),
        //   ),
        // );
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kPrimaryColor, kSecondaryColor],
            ),
          ),
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  widget.item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kBackgroundColor,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
              const SizedBox(width: 100),
              IconButton(
                  onPressed: changeCard,
                  icon: const Icon(Icons.create, color: kBackgroundColor)),
              IconButton(
                  onPressed: deleteWorkflow,
                  icon: const Icon(Icons.delete, color: kBackgroundColor))
            ],
          ),
        ),
      ),
    );
  }
}