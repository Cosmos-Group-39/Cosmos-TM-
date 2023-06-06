import 'package:cosmos_ran/Constants.dart';
import 'package:cosmos_ran/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:cosmos_ran/Workflow%20Management/Widgets/WFSearchBox.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Enter an access code, Email or Phone number',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              workflowsSearch(context),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    minimumSize: const Size(200, 50),
                    shadowColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {},
                  child: const Icon(Icons.send)),
              const SizedBox(height: 20),
              const Divider(
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Start Tracking Now',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 70),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewWorkflowScreen()));
                    },
                    icon: const Icon(
                      Icons.add,
                      weight: 10,
                      size: 100,
                      color: Colors.blueGrey,
                    )),
              ),
              const SizedBox(height: 170),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NewWorkflowScreen()));
                      },
                      child: const Text('Help')),
                  TextButton(onPressed: () {}, child: const Text('About')),
                  TextButton(onPressed: () {}, child: const Text('Contact Us')),
                  TextButton(onPressed: () {}, child: const Text('Feedback')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
