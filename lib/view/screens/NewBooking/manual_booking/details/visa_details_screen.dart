import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class VisaWidget extends StatefulWidget {
  const VisaWidget({super.key});

  @override
  State<VisaWidget> createState() => _VisaWidgetState();
}

class _VisaWidgetState extends State<VisaWidget> {
  String dateOfTravel = "";
  String returnDate = "";
  int adultsNumber = 0;
  int childrenNumber = 0;

  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails =
      []; // List to store children details
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownField(
            label: 'select country:',
            items: const [
              DropdownMenuItem(value: 'Egypt', child: Text('Egypt')),
            ],
            onChanged: (value) {
              log('Selected country: $value');
            },
          ),
          const SizedBox(height: 16),
          CustomDatePickerTextField(
            label: 'Date of Travel',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('yyyy-MM-dd'),
            onDateSelected: (date) {
              setState(() {
                dateOfTravel = date;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomDatePickerTextField(
            label: 'Return Date',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('yyyy-MM-dd'),
            onDateSelected: (date) {
              setState(() {
                returnDate = date;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Adults number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                adultsNumber = int.tryParse(value) ?? 0;
                if (adultsNumber > adultsDetails.length) {
                  adultsDetails.addAll(List<Map<String, dynamic>>.generate(
                    adultsNumber - adultsDetails.length,
                    (_) =>
                        {"gender": null, "firstName": null, "lastName": null},
                  ));
                } else {
                  adultsDetails.removeRange(adultsNumber, adultsDetails.length);
                }
              });
            },
          ),
          const SizedBox(height: 20),
          if (adultsNumber > 0)
            AdultDetailsList(
              count: adultsNumber,
              details: adultsDetails,
              onDetailChanged: (index, key, value) {
                setState(() {
                  adultsDetails[index][key] = value;
                });
              },
            ),

          // Added section for children
          CustomTextField(
            label: 'Children number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                childrenNumber = int.tryParse(value) ?? 0;
                if (childrenNumber > childrenDetails.length) {
                  childrenDetails.addAll(List<Map<String, dynamic>>.generate(
                    childrenNumber - childrenDetails.length,
                    (_) => {"age": null},
                  ));
                } else {
                  childrenDetails.removeRange(
                      childrenNumber, childrenDetails.length);
                }
              });
            },
          ),
          const SizedBox(height: 20),
          if (childrenNumber > 0)
            ChildDetailsList(
              count: childrenNumber,
              details: childrenDetails,
              onDetailChanged: (index, field, value) {
                setState(() {
                  childrenDetails[index][field] = value;
                });
              },
            ),
          const CustomTextField(label: 'note')
        ],
      ),
    );
  }
}
