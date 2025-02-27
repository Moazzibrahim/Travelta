// stepper_column.dart
import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class StepperColumn extends StatelessWidget {
  final String label;
  final bool isCompleted;
  final VoidCallback onTap;

  const StepperColumn({
    super.key,
    required this.label,
    this.isCompleted = false,
    required this.onTap,
    required bool isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? mainColor : Colors.white,
              border: Border.all(color: isCompleted ? mainColor : Colors.grey),
            ),
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isCompleted ? mainColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class StepperRow extends StatelessWidget {
  final List<StepData> steps;
  final int currentIndex;
  final ValueChanged<int> onStepTapped;

  const StepperRow({
    super.key,
    required this.steps,
    required this.currentIndex,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          StepperColumn(
            label: steps[i].label,
            isCompleted: i < currentIndex,
            isActive: i == currentIndex,
            onTap: () => onStepTapped(i),
          ),
          if (i < steps.length - 1)
            const Expanded(
              child: Divider(color: Colors.grey, thickness: 1),
            ),
        ],
      ],
    );
  }
}

class StepData {
  final String label;
  final Widget screen;

  StepData({required this.label, required this.screen});
}
