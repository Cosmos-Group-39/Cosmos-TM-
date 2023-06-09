import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Widgets/userProfilePic.dart';
import 'package:cosmos_client/UserManagement/Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel userModel;

  const UserProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pemailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _pbirthdayController = TextEditingController();
  TextEditingController _pmobileNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late String userprofilePic;
  bool isPremiumSelected = false;
  late String formattedDob;
  final formKey = GlobalKey<FormState>();
  String userId = Uuid().v4();
  DateTime picked = DateTime.now();
  bool isPasswordVisible = false;
  String updatedName = '';
  String updatedEmail = '';

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: picked,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        picked = pickedDate;
        _pbirthdayController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    formattedDob =
        dateFormat.format(widget.userModel.dob); // Format the dob without time
    _nameController.text = widget.userModel.name;
    _pemailController.text = widget.userModel.email;
    _passwordController.text = widget.userModel.password;
    _pbirthdayController.text = formattedDob;
    _pmobileNumberController.text = widget.userModel.mobile;
    _addressController.text = "";
  }

  Widget editFullName() {
    return Expanded(
      child: TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          suffixIcon: Icon(Icons.create),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter First Name';
          }
          return null;
        },
      ),
    );
  }

  Widget editPassword() {
    return Expanded(
      child: TextFormField(
        obscureText: !isPasswordVisible,
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible =
                    !isPasswordVisible; // Toggle the password visibility state
              });
            },
          ),
          suffixIcon: const Icon(Icons.create),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter password';
          }

          if (value.length < 6 || value.length > 8) {
            return 'Password must be between 6 and 8 characters';
          }
          return null;
        },
      ),
    );
  }

  Widget editEmail() {
    return Expanded(
      child: TextFormField(
        controller: _pemailController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          suffixIcon: Icon(Icons.create),
          border: OutlineInputBorder(),
        ),
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

  Widget editMobileNumber() {
    return Expanded(
      child: TextFormField(
        controller: _pmobileNumberController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone),
          suffixIcon: Icon(Icons.create),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter Mobile Number';
          }

          final RegExp regex = RegExp(r'^[0-9]+$');

          if (!regex.hasMatch(value)) {
            return 'Invalid Mobile Number';
          }

          if (value.length != 10) {
            return 'Invalid Mobile Number';
          }
          return null;
        },
      ),
    );
  }

  Widget editBirthday() {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _pbirthdayController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_month),
              suffixIcon: Icon(Icons.create),
              border: OutlineInputBorder(),
            ),
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
      ),
    );
  }

  Widget editAddress() {
    return Expanded(
      child: TextFormField(
        controller: _addressController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          suffixIcon: Icon(Icons.create),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void submitEditedForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        updatedName = _nameController.text;
        updatedEmail = _pemailController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('User Profile'),
        centerTitle: true,
        leading: IconButton(onPressed: null, icon: Icon(Icons.menu)),
      ),
      body: SafeArea(
        child: Container(
          color: null,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Center(
                  child: UserProfilePictureWidget(
                    onImageSelected: (String? imagePath) {
                      setState(() {
                        userprofilePic = imagePath ?? '';
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  updatedName.isNotEmpty ? updatedName : widget.userModel.name,
                  style: const TextStyle(
                    letterSpacing: 3,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  updatedEmail.isNotEmpty
                      ? updatedEmail
                      : widget.userModel.email,
                  style: const TextStyle(
                    letterSpacing: 2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: null,
                  child: const Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 3),
                const SizedBox(height: 20),
                const Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Text Field - Name
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text('Full Name',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 10),
                            editFullName(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text('Password',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 10),
                            editPassword(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text('Email',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 10),
                            editEmail(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text('Birthday',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 10),
                            editBirthday(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text('Mobile Number',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 10),
                            editMobileNumber(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text('Address',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 10),
                            editAddress(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(150, 50)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: submitEditedForm,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
