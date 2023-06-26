import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInOTP.dart';
import 'package:cosmos_client/UserManagement/Screens/SignUp.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginSelected = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() {
    Dio().post('$baseUrls/user/login', data: {
      'email': usernameController.text,
      'password': passwordController.text,
    }).then((value) {
      const storage = FlutterSecureStorage();
      storage.write(key: 'userID', value: value.data['id']);
      storage.write(
          key: 'userName',
          value: ('${value.data['firstName']} ${value.data['lastName']}'));
      storage.write(key: 'userEmail', value: value.data['email']).then(
          (value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())));
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'images/cosmos.png',
                    height: 200,
                    width: 200,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  //swipe tiles of password
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                      ),
                                      primary: isLoginSelected
                                          ? kPrimaryColor
                                          : Colors.grey,
                                      minimumSize: const Size(160, 50),
                                      shadowColor: Colors.black,
                                      alignment: Alignment.center,
                                      elevation: 10,
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
                                        letterSpacing: 2,
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
                                      primary: isLoginSelected
                                          ? Colors.grey
                                          : kPrimaryColor,
                                      minimumSize: const Size(160, 50),
                                      shadowColor: Colors.black,
                                      alignment: Alignment.center,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Loginotp()));
                                      setState(() {
                                        isLoginSelected = false;
                                      });
                                    },
                                    child: const Text(
                                      'OTP',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 2,
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
                              controller: usernameController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  // borderSide: BorderSide(color: Colors.white),
                                ),
                                // labelStyle: TextStyle(color: Colors.white60),
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
                              controller: passwordController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                icon: Icon(Icons.lock_sharp),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  // borderSide: BorderSide(color: Colors.white),
                                ),
                                // labelStyle: TextStyle(color: Colors.white60),
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
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Your Password ?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
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
                              elevation: 10,
                            ),
                            onPressed: () {
                              login();
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 2),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen()));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.4),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
