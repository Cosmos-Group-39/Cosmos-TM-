import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/UserManagement/Screens/LogInPassword.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Loginotp extends StatefulWidget {
  const Loginotp({super.key});

  @override
  _LoginotpState createState() => _LoginotpState();
}

class _LoginotpState extends State<Loginotp> {
  bool isLoginSelected = true;
  int resendTimer = 60;
  Timer? _timer;
  List<String> otpDigits = List.generate(6, (index) => '');

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (resendTimer == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            resendTimer--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController cardControlleremail = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              isLoginSelected ? Colors.grey : kPrimaryColor,
                          minimumSize: const Size(160, 50),
                          shadowColor: Colors.black,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: cardControlleremail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  //validations
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.black,
                  alignment: Alignment.center,
                ),
                onPressed: () {},
                child: const Text(
                  'SEND',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GridView.count(
                  crossAxisCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          otpDigits[index],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: resendTimer > 0
                        ? null
                        : () {
                            setState(() {
                              resendTimer = 60;
                              startResendTimer();
                            });
                          },
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: resendTimer > 0 ? Colors.grey : Colors.green,
                        decoration: resendTimer > 0
                            ? TextDecoration.none
                            : TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    resendTimer > 0 ? ' ($resendTimer)' : '',
                    style: TextStyle(
                      color: resendTimer > 0 ? Colors.grey : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
