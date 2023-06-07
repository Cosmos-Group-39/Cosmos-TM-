import 'package:cosmos_client/Workflow%20Management/Screens/worksWorkflows.dart';
import 'package:flutter/material.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';

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
    _stitleController.text = widget.item.title;
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

  void deletesubWorkflow() {
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

  void changeSubCard() {
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorksWorkflowScreen()));
      },
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
                  onPressed: () => changeSubCard(),
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: kBackgroundColor),
                  onPressed: () => deletesubWorkflow(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
