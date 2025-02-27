import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.onChanged,
    String? value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }
}
