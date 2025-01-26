// flight_widget.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class FlightWidget extends StatefulWidget {
  const FlightWidget({super.key});

  @override
  State<FlightWidget> createState() => _FlightWidgetState();
}

class _FlightWidgetState extends State<FlightWidget> {
  int adultsNumber = 0;
  int childrenNumber = 0;
  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDropdownField(
            label: 'select flight type:',
            items: const [
              DropdownMenuItem(value: '1', child: Text('1')),
            ],
            onChanged: (value) {
              log('Selected  flight type: $value');
            },
          ),
          const SizedBox(height: 16),
          CustomDropdownField(
            label: 'select  flight direction:',
            items: const [
              DropdownMenuItem(value: '1', child: Text('1')),
            ],
            onChanged: (value) {
              log('Selected  flight direction: $value');
            },
          ),
          const SizedBox(height: 16),
          CustomDropdownField(
            label: 'select flight class:',
            items: const [
              DropdownMenuItem(value: '1', child: Text('1')),
            ],
            onChanged: (value) {
              log('Selected flight class: $value');
            },
          ),
          const SizedBox(height: 16),
          CustomDatePickerTextField(
            label: 'Check in',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('dd/MM/yyyy'),
            onDateSelected: (date) {},
          ),
          const SizedBox(
            height: 10,
          ),
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
          const CustomTextField(label: 'adults price', isNumeric: true),
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
          const CustomTextField(label: 'children price', isNumeric: true),
          const SizedBox(height: 20),
          const CustomTextField(label: 'infant number', isNumeric: true),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'airline',
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'ticket number',
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'Ref BNR',
          ),
        ],
      ),
    );
  }
}
