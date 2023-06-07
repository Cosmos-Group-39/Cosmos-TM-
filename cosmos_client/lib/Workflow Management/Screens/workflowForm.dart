// import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
// import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:uuid/uuid.dart';

// class WorkflowFormScreen extends StatefulWidget {
//   const WorkflowFormScreen({Key? key}) : super(key: key);

//   @override
//   _WorkflowFormScreenState createState() => _WorkflowFormScreenState();
// }

// class _WorkflowFormScreenState extends State<WorkflowFormScreen> {
//   final formKeywf = GlobalKey<FormState>();
//   String userId = Uuid().v4();

//   TextEditingController workflowNameController = TextEditingController();

//   // Workflow Name
//   Widget buildWorkflowName() {
//     return TextFormField(
//       controller: workflowNameController,
//       decoration: const InputDecoration(
//         labelText: 'WorkflowName',
//         border: OutlineInputBorder(),
//       ),

//       // Validations
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter WorkflowName';
//         }
//         return null;
//       },
//     );
//   }

//   //Submit Form
//   void submitForm() {
//     if (formKeywf.currentState!.validate()) {
//       formKeywf.currentState!.save();

//       wfcards.add(WorkflowModel(
//         wid: uuid.v4(),
//         title: workflowNameController.text,
//       ));

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CreatedWorkflows(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: createWorkflow(),
//     );
//   }

//   createWorkflow() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: Form(
//               key: formKeywf,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       'Create Workflow',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Icon(
//                     Icons.create,
//                     size: 60.0,
//                     color: Colors.deepOrange,
//                   ),
//                   const SizedBox(height: 10),
//                   const SizedBox(height: 8),
//                   TextField(
//                     controller: workflowNameController,
//                     decoration: const InputDecoration(
//                       hintText: 'Organizaton Name',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             const SizedBox(height: 40),
//             ElevatedButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: const Color(0xff213B6C),
//                 minimumSize: const Size(255.0, 50.0),
//                 shadowColor: Colors.black,
//                 alignment: Alignment.center,
//               ),
//               onPressed: submitForm,
//               child: const Text(
//                 'Confirm',
//                 style: TextStyle(
//                   fontSize: 17,
//                   letterSpacing: 1,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
