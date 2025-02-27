import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:intl/intl.dart';

class CustomDatePickerTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final DateFormat dateFormat;
  final ValueChanged<String> onDateSelected;
  final bool showTimePickerOption;

  const CustomDatePickerTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.dateFormat,
    required this.onDateSelected,
    this.showTimePickerOption = false,
  });

  @override
  _CustomDatePickerTextFieldState createState() =>
      _CustomDatePickerTextFieldState();
}

class _CustomDatePickerTextFieldState extends State<CustomDatePickerTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
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
              style: TextButton.styleFrom(foregroundColor: mainColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      DateTime finalDateTime = pickedDate;

      if (widget.showTimePickerOption) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        }
      }

      String formattedDate = widget.dateFormat.format(finalDateTime);
      setState(() {
        _controller.text =
            formattedDate; // Update text field with selected date
      });
      widget.onDateSelected(formattedDate); // Pass selected date to callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      onTap: _selectDate,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: Icon(widget.icon, color: mainColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }
}
