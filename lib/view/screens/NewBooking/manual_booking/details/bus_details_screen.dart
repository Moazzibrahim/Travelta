// bus_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class BusWidget extends StatefulWidget {
  const BusWidget({super.key});

  @override
  State<BusWidget> createState() => _BusWidgetState();
}

class _BusWidgetState extends State<BusWidget> {
  int adultsNumber = 0;
  int childrenNumber = 0;
  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomTextField(label: 'from'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(label: 'to'),
          const SizedBox(
            height: 10,
          ),
          CustomDatePickerTextField(
            label: 'Check in',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('dd/MM/yyyy'),
            onDateSelected: (date) {},
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDatePickerTextField(
            label: 'Check out',
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
          const SizedBox(height: 10),
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
          const CustomTextField(label: 'bus name'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(label: 'bus number plate'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(label: 'driver phone'),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
