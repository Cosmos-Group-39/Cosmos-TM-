import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OtherMSgWidget extends StatelessWidget {
  final String sender;
  final String msg;

  const OtherMSgWidget({Key? key, required this.msg, required this.sender})
      : super(key: key);

  String _getCurrentDateTime() {
    final now = DateTime.now();
    final rformattedDate = DateFormat('yyyy-MM-dd').format(now);
    final rformattedTime = DateFormat('HH:mm').format(now);
    return '$rformattedDate | $rformattedTime';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 60,
        ),
        child: Card(
          color: Colors.amberAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  msg,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  _getCurrentDateTime(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
