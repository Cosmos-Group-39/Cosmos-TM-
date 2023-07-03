import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

class RatedScreen extends StatefulWidget {
  const RatedScreen({Key? key}) : super(key: key);

  @override
  State<RatedScreen> createState() => _RatedScreenState();
}

class _RatedScreenState extends State<RatedScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Thank You',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: kPrimaryColor, width: 3)),
      titlePadding: const EdgeInsets.all(12.0),
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      content: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: kPrimaryColor),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
