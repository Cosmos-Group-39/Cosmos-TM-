import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentStep = 0;
  List<Step> _steps = [
    Step(
      title: Text('Step 1'),
      content: Text('This is the content of Step 1.'),
      isActive: true,
    ),
    Step(
      title: Text('Step 2'),
      content: Text('This is the content of Step 2.'),
      isActive: true,
    ),
    Step(
      title: Text('Step 3'),
      content: Text('This is the content of Step 3.'),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: _currentStep,
        steps: _steps,
        type: StepperType.horizontal, // Set type to horizontal
        onStepContinue: () {
          setState(() {
            if (_currentStep < _steps.length - 1) {
              _currentStep++;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep--;
            }
          });
        },
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
      ),
    );
  }
}
