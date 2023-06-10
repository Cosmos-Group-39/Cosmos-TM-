// import 'package:cosmos_client/Orgnization/Utils/api_services.dart';
// import 'package:flutter/material.dart';

// class MyFormPage extends StatefulWidget {
//   @override
//   _MyFormPageState createState() => _MyFormPageState();
// }

// class _MyFormPageState extends State<MyFormPage> {
//   final ApiService apiService = ApiService();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController picController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   void _submitForm() async {
//     String name = nameController.text;
//     String pic = picController.text;
//     String description = descriptionController.text;

//     // Call the createOrganization method from the ApiService class
//     await apiService.createOrganization(
//       name: name,
//       pic: pic,
//       description: description,
//     );

//     // Clear the form fields
//     nameController.clear();
//     picController.clear();
//     descriptionController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Form Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextFormField(
//               controller: picController,
//               decoration: InputDecoration(labelText: 'Pic'),
//             ),
//             TextFormField(
//               controller: descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _submitForm,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
