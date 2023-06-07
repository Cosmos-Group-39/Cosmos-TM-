import 'package:flutter/material.dart';

class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({super.key});

  @override
  _ProgressBarWidgetState createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  double _progress = 0.6; // Sample progress value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
            ),
            const SizedBox(height: 8.0),
            Text('${(_progress * 100).toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }
}
