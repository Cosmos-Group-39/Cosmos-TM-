import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:flutter/material.dart';
import '../Models/workflowModels.dart';

/* This is creating new workflws
      main page 
*/

class NewWorkflowScreen extends StatefulWidget {
  const NewWorkflowScreen({Key? key}) : super(key: key);

  @override
  _NewWorkflowScreenState createState() => _NewWorkflowScreenState();
}

class _NewWorkflowScreenState extends State<NewWorkflowScreen> {
  String? selectedTemplate;
  final formKeywf = GlobalKey<FormState>();
  TextEditingController workflowNameController = TextEditingController();

  // Workflow Name
  Widget buildWorkflowName() {
    return TextFormField(
      controller: workflowNameController,
      decoration: const InputDecoration(
        labelText: 'WorkflowName',
        border: OutlineInputBorder(),
      ),

      // Validations
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter WorkflowName';
        }
        return null;
      },
    );
  }

  void submitForm() {
    if (formKeywf.currentState!.validate()) {
      formKeywf.currentState!.save();

      wfcards.add(WorkflowModel(
        wid: uuid.v4(),
        title: workflowNameController.text,
        active: true,
        type: 'free',
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatedWorkflows(),
        ),
      );
    }
  }

  createWorkflow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: kPrimaryColor, width: 5)),
          content: SingleChildScrollView(
            child: Form(
              key: formKeywf,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Create Workflow',
                      style: kAlertBoxTopicTextStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Icon(
                      Icons.create,
                      size: 60.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: workflowNameController,
                    decoration: const InputDecoration(
                      hintText: 'Workflow Name',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle, //Elevated button style
                onPressed: submitForm,
                child: const Text(
                  'Create',
                  style: kAlertBoxButtonTextStyle, //Elevated button Text style
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.blue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Image.asset(
                    'images/cosmos.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Text('New Workflow',
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.3,
                      wordSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                    )),
                const SizedBox(height: 40),
                const Divider(
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 40),
                Text(
                  'Use a Template',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.3,
                    wordSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //Templates
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
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
                        value: selectedTemplate,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTemplate = newValue;
                          });
                        },
                        items: <String>[
                          '    Parcel Tracking',
                          '    Project Management',
                          '    Application Tracking',
                          '    Goal Tracking',
                          '    Expense Tracking',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: const Size(70, 40),
                          shadowColor: Colors.black,
                          alignment: Alignment.center,
                          elevation: 10,
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 25,
                        )),
                    const SizedBox(width: 15),
                  ],
                ),
                const SizedBox(height: 40),
                const Divider(
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 30),

                //Custom workflow
                Text(
                  'Custom Workflow',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.3,
                    wordSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size(130, 50),
                      shadowColor: Colors.black,
                      alignment: Alignment.center,
                      elevation: 10,
                    ),
                    onPressed: createWorkflow,
                    child: const Text(
                      'Create',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 1.3,
                      ),
                    )),
                const SizedBox(height: 40),
                const Divider(
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 40),

                //custom workflow
                Text(
                  'Import a Template',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.3,
                    wordSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size(130, 50),
                      shadowColor: Colors.black,
                      alignment: Alignment.center,
                      elevation: 10,
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.file_download_outlined,
                      size: 30,
                    )),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
