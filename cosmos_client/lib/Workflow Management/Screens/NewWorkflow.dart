import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourWorkflow.dart';
import 'package:flutter/material.dart';
import '../Models/workflowModels.dart';

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
          content: SingleChildScrollView(
            child: Form(
              key: formKeywf,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Create Workflow',
                      style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.create,
                    size: 60.0,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 8),
                  TextField(
                    controller: workflowNameController,
                    decoration: const InputDecoration(
                      hintText: 'Organizaton Name',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            const SizedBox(height: 40),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff213B6C),
                minimumSize: const Size(255.0, 50.0),
                shadowColor: Colors.black,
                alignment: Alignment.center,
              ),
              onPressed: submitForm,
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'Images/CosmosLogo.jpg',
                  height: 200,
                  width: 200,
                ),
              ),
              const Text(
                'New Workflow',
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Divider(
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 40),
              const Text(
                'Use a Template',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),

              //templates
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional.center,
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
                    'Parcel Tracking',
                    'Project Management',
                    'Application Tracking',
                    'Goal Tracking',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              const Divider(
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 30),

              //custom workflow
              const Text(
                'Custom Workflow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    minimumSize: const Size(130, 50),
                    shadowColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: createWorkflow,
                  child: const Text(
                    'Create',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  )),
              const SizedBox(height: 40),
              const Divider(
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 40),

              //custom workflow
              const Text(
                'Import a Template',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    minimumSize: const Size(130, 50),
                    shadowColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.file_download_outlined,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
