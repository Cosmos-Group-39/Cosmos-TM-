import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:flutter/material.dart';

class SubWorkflowCard extends StatefulWidget {
  final Function(SubWorkflowModel) subwfonEdit;
  final Function(String) subwfonDelete;
  final SubWorkflowModel item;

  const SubWorkflowCard({
    Key? key,
    required this.item,
    required this.subwfonDelete,
    required this.subwfonEdit,
  }) : super(key: key);

  @override
  State<SubWorkflowCard> createState() => _SubWorkflowCardState();
}

class _SubWorkflowCardState extends State<SubWorkflowCard> {
  TextEditingController _stitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stitleController.dispose();
    super.dispose();
  }

  void subwfeditCard() {
    String title = _stitleController.text.trim();

    SubWorkflowModel subwf_editedItem = SubWorkflowModel(
      swid: widget.item.swid,
      title: title,
    );

    widget.subwfonEdit(subwf_editedItem);
  }

  //Delete sub workflow
  deletesubWorkflow() {
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
                    'You want to delete the SubWorkflow !',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.subwfonDelete(widget.item.swid);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  //Update subworkflow
  changeSubCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Update Sub Workflow',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.edit_document,
                  size: 60.0,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _stitleController,
                  decoration: const InputDecoration(
                    hintText: 'Sub Workflow Name',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                subwfeditCard();
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
              const SizedBox(width: 100),
              IconButton(
                  onPressed: changeSubCard,
                  icon: const Icon(Icons.create, color: kBackgroundColor)),
              IconButton(
                  onPressed: deletesubWorkflow,
                  icon: const Icon(Icons.delete, color: kBackgroundColor))
            ],
          ),
        ),
      ),
    );
  }
}
