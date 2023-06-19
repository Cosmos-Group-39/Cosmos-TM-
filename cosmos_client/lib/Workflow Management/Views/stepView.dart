import 'package:cosmos_client/Workflow%20Management/View%20Cards/stepViewCard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class StepViewWorksScreen extends StatefulWidget {
  dynamic subworkflow;
  final String workflowName;
  StepViewWorksScreen(
      {super.key, required this.subworkflow, required this.workflowName});

  @override
  State<StepViewWorksScreen> createState() => _StepViewWorksScreenState();
}

class _StepViewWorksScreenState extends State<StepViewWorksScreen> {
  List<WorkModel> workcards = [];
  Uuid uuid = const Uuid();
  TextEditingController _workController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _workController.dispose();
    super.dispose();
  }

  void createWorks() {
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
                  'Create Work',
                  style: kAlertBoxTopicTextStyle,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.add,
                  size: 60.0,
                  color: Colors.green,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _workController,
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
                  String title = _workController.text.trim();
                  String workid = uuid.v4();
                  WorkModel work_newItem = WorkModel(
                    workid: workid,
                    title: title,
                    active: true,
                  );

                  setState(() {
                    workcards.add(work_newItem);
                  });

                  Navigator.pop(context);
                  _workController.clear();
                },
                child: const Text(
                  'Create',
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

  void deleteWorks(String workid) {
    setState(() {
      workcards.removeWhere((element) => element.workid == workid);
    });
  }

  void editWorks(WorkModel editedItem) {
    setState(() {
      int index = workcards
          .indexWhere((element) => element.workid == editedItem.workid);
      workcards[index] = editedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.workflowName,
          style: kAppBarTitle,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatedSubWorkflows()));
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GroupPage(
                            name: '',
                            userId: '',
                          )));
            },
            child: const Icon(Icons.chat_bubble),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // Set the desired radius here
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => createWorks(),
        child: const Icon(
          Icons.add,
          color: kDefaultIconLightColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.subworkflow['title'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            buildStepView(),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: workcards.length,
                itemBuilder: (context, index) {
                  return StepViewWorksCard(
                    item: workcards[index],
                    workonDelete: (workid) => deleteWorks(workid),
                    workonEdit: (editedItem) => editWorks(editedItem),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepView() {
    int activeStep = 5; // Initial step set to 5.
    int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

    return Column(
      children: [
        IconStepper(
          // ignore: prefer_const_literals_to_create_immutables
          icons: [
            const Icon(Icons.check),
            const Icon(Icons.flag),
            const Icon(Icons.access_alarm),
            const Icon(Icons.supervised_user_circle),
            const Icon(Icons.flag),
            const Icon(Icons.access_alarm),
            const Icon(Icons.supervised_user_circle),
          ],
          activeStep: activeStep,
          onStepReached: (index) {
            activeStep = index;
          },
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  getHeaderText(activeStep),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getHeaderText(int activeStep) {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Submission --> 2023/05/05';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}

// class StepViewWidget extends StatefulWidget {
//   @override
//   _StepViewWidget createState() => _StepViewWidget();
// }

// class _StepViewWidget extends State<StepViewWidget> {
//   // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
//   int activeStep = 5; // Initial step set to 5.

//   int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               IconStepper(
//                 icons: [
//                   Icon(Icons.supervised_user_circle),
//                   Icon(Icons.flag),
//                   Icon(Icons.access_alarm),
//                   Icon(Icons.supervised_user_circle),
//                   Icon(Icons.flag),
//                   Icon(Icons.access_alarm),
//                   Icon(Icons.supervised_user_circle),
//                 ],

//                 // activeStep property set to activeStep variable defined above.
//                 activeStep: activeStep,

//                 // This ensures step-tapping updates the activeStep.
//                 onStepReached: (index) {
//                   setState(() {
//                     activeStep = index;
//                   });
//                 },
//               ),
//               header(),
//               // Expanded(
//               //   child: FittedBox(
//               //     child: Center(
//               //       child: Text('$activeStep'),
//               //     ),
//               //   ),
//               // ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     previousButton(),
//               //     nextButton(),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Returns the next button.
//   // Widget nextButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       // Increment activeStep, when the next button is tapped. However, check for upper bound.
//   //       if (activeStep < upperBound) {
//   //         setState(() {
//   //           activeStep++;
//   //         });
//   //       }
//   //     },
//   //     child: Text('Next'),
//   //   );
//   // }

//   /// Returns the previous button.
//   // Widget previousButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
//   //       if (activeStep > 0) {
//   //         setState(() {
//   //           activeStep--;
//   //         });
//   //       }
//   //     },
//   //     child: Text('Prev'),
//   //   );
//   // }

//   /// Returns the header wrapping the header text.
//   Widget header() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.orange,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               headerText(),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Returns the header text based on the activeStep.
//   String headerText() {
//     switch (activeStep) {
//       case 1:
//         return 'Preface';

//       case 2:
//         return 'Table of Contents';

//       case 3:
//         return 'About the Author';

//       case 4:
//         return 'Publisher Information';

//       case 5:
//         return 'Reviews';

//       case 6:
//         return 'Chapters #1';

//       default:
//         return 'Introduction';
//     }
//   }
// }
