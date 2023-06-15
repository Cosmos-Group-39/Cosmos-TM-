import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_client/UserManagement/Screens/SignUp.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/NewWorkflow.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'images/cosmos.png',
                    height: 200,
                    width: 200,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Enter an access code, Email or Phone number',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(2, 2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                workflowsSearch(),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    minimumSize: const Size(200, 50),
                    shadowColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.send,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(thickness: 2),
                const SizedBox(height: 50),
                const Text(
                  'Create Workflow',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewWorkflowScreen()));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(100, 50),
                        shadowColor: Colors.black,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(100, 50),
                        shadowColor: Colors.black,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget workflowsSearch() {
    String searchValue = '';
    final List<String> _suggestions = [
      'Afeganistan',
      'Albania',
      'Algeria',
      'Australia',
      'Brazil',
      'German',
      'Madagascar',
      'Mozambique',
      'Portugal',
      'Zambia'
    ];
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 45, bottom: 45, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: null,
        borderRadius: BorderRadius.circular(2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: EasySearchBar(
        title: const Text(
          'Access code, Email or Phone number',
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white54,
        onSearch: (value) => setState(() => searchValue = value),
      ),
    );
  }
}
