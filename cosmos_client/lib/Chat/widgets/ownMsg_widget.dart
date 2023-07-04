import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnMSgWidget extends StatelessWidget {
  final String user;
  final String content;
  final String userName; // Add userName parameter

  const OwnMSgWidget({
    Key? key,
    required this.content,
    required this.user,
    required this.userName,
  }) : super(key: key);

  String _getCurrentDateTime() {
    final now = DateTime.now();
    final sformattedDate = DateFormat('yyyy-MM-dd').format(now);
    final sformattedTime = DateFormat('HH:mm').format(now);
    return '$sformattedDate | $sformattedTime';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 60,
        ),
        child: Card(
          color: Colors.teal,
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
                  userName, // Use the userName parameter
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _getCurrentDateTime(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
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
