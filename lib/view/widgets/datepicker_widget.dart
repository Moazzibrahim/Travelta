import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:intl/intl.dart';

class CustomDatePickerTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final DateFormat dateFormat;
  final ValueChanged<String> onDateSelected;

  const CustomDatePickerTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.dateFormat,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: mainColor,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: mainColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = dateFormat.format(pickedDate);
          onDateSelected(formattedDate);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(icon, color: mainColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }
}
