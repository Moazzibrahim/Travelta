import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class MarkupButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String selectedMarkup;

  const MarkupButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.selectedMarkup,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(8),
          color: selectedMarkup == text
              ? mainColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedMarkup == text ? mainColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
