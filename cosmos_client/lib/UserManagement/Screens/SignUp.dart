import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:cosmos_client/UserManagement/Screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  String userId = Uuid().v4();
  DateTime picked = DateTime.now(); // Declare and initialize the variable here

  String initialCountry = 'LK';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'LK');

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
          border: OutlineInputBorder(),
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
          border: OutlineInputBorder(),
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
        keyboardType: TextInputType
            .emailAddress, // Set the keyboard type to email address

        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),

        // Validations
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter an email address';
          }

          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9+\.[a-zA-Z]+")
              .hasMatch(value);

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
        labelText: '6-8 characters',
        border: OutlineInputBorder(),
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
        border: OutlineInputBorder(),
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
        picked =
            (await _selectDate(context))!; // Assign the value to the variable

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
            border: OutlineInputBorder(),
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
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber mobile) {
        // Validate number length
        if (mobile.phoneNumber?.length == 9) {
          setState(() {
            phoneNumber = mobile;
          });
        }
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        setSelectorButtonAsPrefixIcon: true,
      ),
      initialValue: phoneNumber,
      countries: const ['US', 'CA', 'IN', 'LK'], // List of supported countries
      textFieldController: mobileNumberController,
      inputDecoration: const InputDecoration(
        hintText: 'Enter your phone number',
        border: OutlineInputBorder(),
      ),
      formatInput: true,
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      onSaved: (PhoneNumber mobile) {},
    );
  }

  //Submit Form
  void submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      UserModel userModel = UserModel(
        id: userId,
        name: firstNController.text + " " + lastNController.text,
        email: emailController.text,
        password: confirmPasswordController.text,
        dob: picked,
        mobile: mobileNumberController.text,
        active: false, // Set the initial active status as false
        profilePic: '',
        address: '',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(userModel: userModel),
        ),
      );
    }
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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              //Register form
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text('Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600)),
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
                      const Text('Create a password',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildCreatePassword(),
                      ),
                      const SizedBox(height: 20),
                      const Text('Confirm your password',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildConfirmPassword(),
                      ),
                      const SizedBox(height: 20),
                      const Text('Email',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildEmail(),
                      ),
                      const SizedBox(height: 20),
                      const Text('Birthday',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildBirthday(),
                      ),
                      const SizedBox(height: 20),
                      const Text('Mobile number',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600)),
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
                ),

                //Call submitForm when the button is pressed

                onPressed: submitForm,

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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
