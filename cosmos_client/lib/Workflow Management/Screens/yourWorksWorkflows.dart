// import 'package:cosmos_client/Chat/Screen/chat_group.dart';
// import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
// import 'package:cosmos_client/Workflow%20Management/Widgets/worksWorkflowCard.dart';
// import 'package:flutter/material.dart';
// import 'package:cosmos_client/Constants.dart';
// import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
// import 'package:uuid/uuid.dart';

// class WorksScreen extends StatefulWidget {
//   const WorksScreen({Key? key}) : super(key: key);

//   @override
//   State<WorksScreen> createState() => _WorksScreenState();
// }

// class _WorksScreenState extends State<WorksScreen> {
//   List<WorkModel> workcards = [];
//   Uuid uuid = Uuid();
//   TextEditingController _workController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _workController.dispose();
//     super.dispose();
//   }

//   void createWorks() {
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
//                   'Create Work',
//                   style: kAlertBoxTopicTextStyle,
//                 ),
//                 const SizedBox(height: 10),
//                 const Icon(
//                   Icons.add,
//                   size: 60.0,
//                   color: Colors.green,
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: _workController,
//                   decoration: const InputDecoration(
//                     hintText: 'Work Name',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 String title = _workController.text.trim();
//                 String wwid = uuid.v4();
//                 WorkModel work_newItem = WorkModel(
//                   workid: wwid,
//                   title: title,
//                   active: true,
//                 );

//                 setState(() {
//                   workcards.add(work_newItem);
//                 });

//                 Navigator.pop(context);
//                 _workController.clear();
//               },
//               child: const Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void deleteWorks(String workid) {
//     setState(() {
//       workcards.removeWhere((element) => element.workid == workid);
//     });
//   }

//   void editWorks(WorkModel editedItem) {
//     setState(() {
//       int index = workcards
//           .indexWhere((element) => element.workid == editedItem.workid);
//       workcards[index] = editedItem;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         title: const Text('Works'),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CreatedSubWorkflows()));
//             },
//             icon: const Icon(Icons.arrow_back)),
//         actions: [
//           FloatingActionButton(
//             backgroundColor: kPrimaryColor,
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => GroupPage(
//                             name: '',
//                             userId: '',
//                           )));
//             },
//             child: const Icon(Icons.chat_bubble),
//             shape: RoundedRectangleBorder(
//               borderRadius:
//                   BorderRadius.circular(10.0), // Set the desired radius here
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: kPrimaryColor,
//         onPressed: () => createWorks(),
//         child: const Icon(Icons.add),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: ListView.builder(
//           itemCount: workcards.length,
//           itemBuilder: (context, index) {
//             return WorksCard(
//               item: workcards[index],
//               workonDelete: (wwid) => deleteWorks(wwid),
//               workonEdit: (editedItem) => editWorks(editedItem),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
