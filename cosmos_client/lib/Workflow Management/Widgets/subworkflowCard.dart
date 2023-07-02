// import 'package:cosmos_client/Workflow%20Management/Screens/yourWorksWorkflows.dart';
// import 'package:flutter/material.dart';
// import 'package:cosmos_client/Constants.dart';
// import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';

// class SubWorkflowCard extends StatefulWidget {
//   final Function(SubWorkflowModel) subwfonEdit;
//   final Function(String) subwfonDelete;
//   final SubWorkflowModel item;

//   const SubWorkflowCard({
//     Key? key,
//     required this.item,
//     required this.subwfonDelete,
//     required this.subwfonEdit,
//   }) : super(key: key);

//   @override
//   State<SubWorkflowCard> createState() => _SubWorkflowCardState();
// }

// class _SubWorkflowCardState extends State<SubWorkflowCard> {
//   TextEditingController _stitleController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _stitleController.text = widget.item.title;
//   }

//   @override
//   void dispose() {
//     _stitleController.dispose();
//     super.dispose();
//   }

//   void subwfeditCard() {
//     String title = _stitleController.text.trim();

//     SubWorkflowModel subwf_editedItem = SubWorkflowModel(
//       subid: widget.item.subid,
//       title: title,
//       view: '',
//     );

//     widget.subwfonEdit(subwf_editedItem);
//   }

// //Delete Subworkflow Card
//   void deletesubWorkflow() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: kAlertBoxBorderStyle,
//           title: const Icon(
//             Icons.delete,
//             size: 60.0,
//             color: Colors.green,
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Are You Sure ?',
//                   style: kAlertBoxTopicTextStyle,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(top: 20, left: 17),
//                   child: Text(
//                     'You want to delete the SubWorkflow !',
//                     style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 style: kAlertBoxButtonStyle, //Elevated button style
//                 onPressed: () {
//                   widget.subwfonDelete(widget.item.subid!);
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Delete',
//                   style: kAlertBoxButtonTextStyle, //Elevated button Text style
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//       },
//     );
//   }

// //Edit Subworkflow Card
//   void changeSubCard() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: kAlertBoxBorderStyle,
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Update Sub Workflow',
//                   style: kAlertBoxTopicTextStyle,
//                 ),
//                 const Divider(thickness: 3),
//                 const SizedBox(height: 10),
//                 const Icon(
//                   Icons.edit_document,
//                   size: 60.0,
//                   color: Colors.green,
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: _stitleController,
//                   decoration: const InputDecoration(
//                     hintText: 'Sub Workflow Name',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//           actions: [
//             Center(
//               child: ElevatedButton(
//                 style: kAlertBoxButtonStyle,
//                 onPressed: () {
//                   subwfeditCard();
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Confirm',
//                   style: kAlertBoxButtonTextStyle,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8)
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(25),
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const WorksScreen()));
//       },
//       child: Card(
//         elevation: 10,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//         margin: const EdgeInsets.only(bottom: 30),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             color: kPrimaryColor,
//           ),
//           padding: const EdgeInsets.only(
//             top: 25,
//             bottom: 25,
//             right: 25,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Flexible(
//                 flex: 3,
//                 child: Text(
//                   widget.item.title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: kBackgroundColor,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 60),
//               Flexible(
//                 flex: 1,
//                 child: IconButton(
//                   icon: const Icon(Icons.edit, color: kBackgroundColor),
//                   onPressed: () => changeSubCard(),
//                 ),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: IconButton(
//                   icon: const Icon(Icons.delete, color: kBackgroundColor),
//                   onPressed: () => deletesubWorkflow(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
