import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInOTP.dart';
import 'package:cosmos_client/UserManagement/Screens/SignUp.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController cardControllerusername = TextEditingController();
    TextEditingController cardControllerpassword = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //       kPrimaryColor.withOpacity(0.1),
          //       kSecondaryColor.withOpacity(0.3)
          //     ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'Images/CosmosLogo.jpg',
                  height: 250,
                  width: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      //swipe tiles of password
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              isLoginSelected ? kPrimaryColor : Colors.grey,
                          minimumSize: const Size(160, 50),
                          shadowColor: Colors.black,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          setState(() {
                            isLoginSelected = true;
                          });
                        },
                        child: const Text(
                          'PASSWORD',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      //swipe tiles of OTP
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              isLoginSelected ? Colors.grey : kPrimaryColor,
                          minimumSize: const Size(160, 50),
                          shadowColor: Colors.black,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginotp()));
                          setState(() {
                            isLoginSelected = false;
                          });
                        },
                        child: const Text(
                          'OTP',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: cardControllerusername,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),

                  //validations
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: cardControllerpassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.lock_sharp),
                    border: OutlineInputBorder(),
                  ),

                  //validations
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Your Password ?'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(200, 50),
                  shadowColor: Colors.black,
                  alignment: Alignment.center,
                ),
                onPressed: () {},
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, wordSpacing: 2),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
