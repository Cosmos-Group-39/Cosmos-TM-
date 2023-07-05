import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:cosmos_client/UserManagement/Screens/userProfile.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime picked = DateTime.now(); // Declare and initialize the variable here

  // String initialCountry = 'LK';
  // PhoneNumber phoneNumber = PhoneNumber(isoCode: 'LK');

  bool isLoginSelected = true;

  TextEditingController firstNController = TextEditingController();
  TextEditingController lastNController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return picked;
  }

  // First Name
  Widget buildFirstName() {
    return Expanded(
      child: TextFormField(
        controller: firstNController,

        decoration: const InputDecoration(
          labelText: 'First Name',
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            // borderSide: BorderSide(color: Colors.white),
          ),
          // labelStyle: TextStyle(color: Colors.white60),
        ),

        // Validations
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter First Name';
          }
          return null;
        },
      ),
    );
  }

  // Last Name
  Widget buildLastName() {
    return Expanded(
      child: TextFormField(
        controller: lastNController,

        decoration: const InputDecoration(
          labelText: 'Last Name',
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            // borderSide: BorderSide(color: Colors.white),
          ),
          // labelStyle: TextStyle(color: Colors.white60),
        ),

        // Validations

        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter Last Name';
          }
          return null;
        },
      ),
    );
  }

  //Email
  Widget buildEmail() {
    return Expanded(
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress, // Set the keyboard type to email address

        decoration: const InputDecoration(
          labelText: 'Email',
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            // borderSide: BorderSide(color: Colors.white),
          ),
          // labelStyle: TextStyle(color: Colors.white60),
        ),

        // Validations
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter an email address';
          }

          bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9+\.[a-zA-Z]+").hasMatch(value);

          if (!emailValid) {
            return 'Enter a valid email address';
          }

          return null;
        },
      ),
    );
  }

  // Create Password
  Widget buildCreatePassword() {
    return TextFormField(
      controller: createPasswordController,

      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock_open),
        labelText: '6-8 characters',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // borderSide: BorderSide(color: Colors.white),
        ),
        // labelStyle: TextStyle(color: Colors.white60),
      ),

      // Validations

      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter password';
        }

        if (value.length < 6 || value.length > 8) {
          return 'Password must be between 6 and 8 characters';
        }

        return null;
      },
    );
  }

  // Confirm Password
  Widget buildConfirmPassword() {
    return TextFormField(
      controller: confirmPasswordController,
      decoration: const InputDecoration(
        labelText: 'min 6-8 characters',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // borderSide: BorderSide(color: Colors.white),
        ),
        // labelStyle: TextStyle(color: Colors.white60),
      ),

      // Validations

      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter password';
        }

        if (value != createPasswordController.text) {
          return 'Incorrect password';
        }

        return null;
      },
    );
  }

  // Birthday
  Widget buildBirthday() {
    return GestureDetector(
      onTap: () async {
        picked = (await _selectDate(context))!; // Assign the value to the variable

        if (picked != null) {
          setState(() {
            birthdayController.text = DateFormat('dd/MM/yyyy').format(picked);
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: birthdayController,
          decoration: const InputDecoration(
            labelText: 'DD/MM/YYYY',
            prefixIcon: Icon(Icons.edit_calendar),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              // borderSide: BorderSide(color: Colors.white),
            ),
            // labelStyle: TextStyle(color: Colors.white60),
          ),
          // Validations
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a birthday';
            }

            final parts = value.split('/');

            if (parts.length != 3) {
              return 'Invalid format. Please enter in DD/MM/YYYY format';
            }

            final day = int.tryParse(parts[0]);
            final month = int.tryParse(parts[1]);
            final year = int.tryParse(parts[2]);
            final currentYear = DateTime.now().year;

            if (day == null || month == null || year == null) {
              return 'Invalid format';
            }

            if (year > currentYear) {
              return 'Enter a valid year';
            }

            if (month < 1 || month > 12) {
              return 'Enter a valid month';
            }

            final daysInMonth = DateTime(year, month + 1, 0).day;

            if (day < 1 || day > daysInMonth) {
              return 'Enter a valid date';
            }

            return null;
          },
        ),
      ),
    );
  }

  // Mobie Number
  Widget buildMobileNo() {
    return TextFormField(
      controller: mobileNumberController,
      decoration: const InputDecoration(
        labelText: 'Enter your phone number',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // borderSide: BorderSide(color: Colors.white),
        ),
        // labelStyle: TextStyle(color: Colors.white60),
      ),

      // Validations
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Mobile Number';
        }

        if (value.length != 10) {
          return 'Invalid Mobile Number';
        }

        return null;
      },
    );
  }

  // // Mobie Number
  // Widget buildMobileNo() {
  //   return InternationalPhoneNumberInput(
  //     onInputChanged: (PhoneNumber mobile) {
  //       // Validate number length and null value
  //       if (mobile.phoneNumber != null && mobile.phoneNumber!.length == 10) {
  //         setState(() {
  //           phoneNumber = mobile;
  //         });
  //       }
  //     },
  //     selectorConfig: const SelectorConfig(
  //       selectorType: PhoneInputSelectorType.DROPDOWN,
  //       setSelectorButtonAsPrefixIcon: true,
  //     ),
  //     initialValue: phoneNumber,
  //     countries: const ['US', 'CA', 'IN', 'LK'], // List of supported countries
  //     textFieldController: mobileNumberController,
  //     inputDecoration: const InputDecoration(
  //       hintText: 'Enter your phone number',
  //       border: OutlineInputBorder(),
  //     ),
  //     formatInput: true,
  //     keyboardType: const TextInputType.numberWithOptions(signed: true),
  //     onSaved: (PhoneNumber mobile) {},
  //   );
  // }

  //Submit Form
  void submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      UserModel userModel = UserModel(
        firstName: firstNController.text,
        lastName: lastNController.text,
        email: emailController.text,
        password: confirmPasswordController.text,
        dob: picked,
        mobile: mobileNumberController.text,
        isDeleted: false,
        subcription: 'free',
      );

      Dio().post('$baseUrls/user/register', data: {
        'firstName': firstNController.text,
        'lastName': lastNController.text,
        'email': emailController.text,
        'mobile': mobileNumberController.text,
        'password': confirmPasswordController.text,
        'address': null,
        'dob': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(picked.toString())),
        'profilePic': null,
        'isDeleted': false,
        'subscription': 'free',
        'workflows': [],
        'organizations': [],
        'reviews': []
      }).then((value) {
        print("User Added");
        userModel.id = value.data['_id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }).catchError((error) {
        print(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Image.asset(
                    'images/cosmos.png',
                    height: 180,
                    width: 180,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 0.79,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Create Account',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 1.3,
                                  wordSpacing: 1.5,
                                  shadows: [
                                    Shadow(color: Colors.black.withOpacity(0.2), offset: Offset(2, 2), blurRadius: 2),
                                  ],
                                )),
                          ),

                          const SizedBox(height: 25),

                          //Register form
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Text('Name',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        letterSpacing: 1.3,
                                        wordSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        buildFirstName(),
                                        const SizedBox(width: 10),
                                        buildLastName(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Create a password',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        letterSpacing: 1.3,
                                        wordSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: buildCreatePassword(),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Confirm your password',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        letterSpacing: 1.3,
                                        wordSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: buildConfirmPassword(),
                                  ),
                                  const SizedBox(height: 15),
                                  Text('Email',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        letterSpacing: 1.3,
                                        wordSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: buildEmail(),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Birthday',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        letterSpacing: 1.3,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: buildBirthday(),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Mobile number',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        letterSpacing: 1.3,
                                        wordSpacing: 1.5,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: buildMobileNo(),
                                  ),
                                ],
                              )),

                          const SizedBox(height: 20),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              minimumSize: const Size(200, 50),
                              shadowColor: Colors.black,
                              alignment: Alignment.center,
                              elevation: 10,
                            ),

                            //Call submitForm when the button is pressed

                            onPressed: submitForm,

                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
