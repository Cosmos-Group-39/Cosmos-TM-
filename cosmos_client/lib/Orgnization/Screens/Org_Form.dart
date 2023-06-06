import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cosmos_ran/Orgnization/Screens/Your_Org.dart';
import 'package:cosmos_ran/Orgnization/Widgets/Profile_Pic.dart';
import 'package:cosmos_ran/Orgnization/Widgets/Const_Texts.dart';
import 'package:cosmos_ran/Orgnization/Utils/api_services.dart';
import 'package:cosmos_ran/Orgnization/Utils/FormValidation.dart';
import 'package:cosmos_ran/Constants.dart';

class OrgForm extends StatefulWidget {
  const OrgForm({Key? key}) : super(key: key);

  @override
  State<OrgForm> createState() => _OrgFormState();
}

class _OrgFormState extends State<OrgForm> {
  final formKey = GlobalKey<FormState>();
  ApiService apiService = ApiService();
  TextEditingController cardControllername = TextEditingController();
  TextEditingController cardControllerDes = TextEditingController();
  late String profilePic;

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Call the API to create the organization
      try {
        await apiService.createOrganization(
          name: cardControllername.text,
          pic: profilePic, // Provide the appropriate value for pic
          description: cardControllerDes.text,
        );

        cardsx.add(
          FormModel(
            cardID: uuid.v1(),
            cardName: cardControllername.text,
            description: cardControllerDes.text,
            profilePic: profilePic,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateCards()),
        );

        cardControllername.clear();
        cardControllerDes.clear();
        _resetProfilePicture();
      } catch (e) {
        // Handle the API call exception
        print('Exception occurred: $e');
      }
    }
  }

  void _resetProfilePicture() {
    setState(() {
      profilePic = '';
    });
  }

  Widget buildOrgNameField() {
    return TextFormField(
      controller: cardControllername,
      maxLength: 20,
      decoration: const InputDecoration(
        labelText: 'Enter Organization Name *',
        border: OutlineInputBorder(),
      ),
      // Validations
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your organization name';
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters long';
        }
        if (value.length > 20) {
          return 'Name must be less than 20 characters long';
        }
        return null;
      },
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      controller: cardControllerDes,
      maxLength: 1000,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Description*',
        border: OutlineInputBorder(),
      ),

      // Validations
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description';
        }
        if (value.length < 2) {
          return 'Description must be at least 2 characters long';
        }
        if (value.length > 1000) {
          return 'Description must be less than 1000 characters long';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Organization',
          style: TextStyle(fontSize: 20, letterSpacing: 0.4),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: kBackgroundColor),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 15),
                      Center(child: orgFormText(context)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ProfilePictureWidget(
                          onImageSelected: (String? imagePath) {
                            setState(() {
                              profilePic = imagePath ?? '';
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: buildOrgNameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: buildDescriptionField(),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40.0)),
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
