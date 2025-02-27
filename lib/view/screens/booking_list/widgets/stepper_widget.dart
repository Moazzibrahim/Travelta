import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({super.key, required this.status});
  final String status;

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    // Map status to the corresponding step index
    switch (widget.status.toLowerCase()) {
      case 'pending':
        activeStep = 0;
        break;
      case 'confirmed':
        activeStep = 1;
        break;
      case 'vouchered':
        activeStep = 2;
        break;
      default:
        activeStep = 0; // Default to first step if status is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      lineStyle: LineStyle(
        lineLength: 110,
        lineType: activeStep == 2 ? LineType.dotted : LineType.normal,
        finishedLineColor: Colors.green,
      ),
      stepRadius: 20,
      finishedStepBorderColor: Colors.green,
      finishedStepBackgroundColor: Colors.green,
      showLoadingAnimation: false,
      steps: const [
        EasyStep(
          icon: Icon(Icons.check, color: Colors.white),
          activeIcon: Icon(Icons.radio_button_unchecked, color: Colors.grey),
          title: 'Pending',
          lineText: '',
        ),
        EasyStep(
          icon: Icon(Icons.check, color: Colors.white),
          activeIcon: Icon(Icons.radio_button_unchecked, color: Colors.grey),
          title: 'Confirmed',
          lineText: '',
        ),
        EasyStep(
          icon: Icon(Icons.check, color: Colors.white),
          activeIcon: Icon(Icons.circle, color: Colors.green),
          title: 'Vouchered',
          lineText: '',
        ),
      ],
      onStepReached: (index) {
        setState(() {
          activeStep = index;
        });
      },
    );
  }
}
