import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    return TextFormField(
      cursorColor: mainColor,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor),
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        return null;
      },
    );
  }