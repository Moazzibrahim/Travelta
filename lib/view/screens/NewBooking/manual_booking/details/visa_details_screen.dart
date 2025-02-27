import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  final List<Map<String, dynamic>> childrenDetails = [];

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownField(
            label: 'Select country:',
            items: const [
              DropdownMenuItem(value: 'Egypt', child: Text('Egypt')),
            ],
            onChanged: (value) {
              setState(() {
                dataListProvider.visaData.country = value;
              });
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
                dataListProvider.visaData.dateOfTravel =
                    date; // Save date of travel
              });
            },
          ),
          const SizedBox(height: 16),

          // Return date
          CustomDatePickerTextField(
            label: 'Return Date',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('yyyy-MM-dd'),
            onDateSelected: (date) {
              setState(() {
                returnDate = date;
                dataListProvider.visaData.returnDate = date;
              });
            },
          ),
          const SizedBox(height: 16),

          // Adults number
          CustomTextField(
            label: 'Adults number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                adultsNumber = inputNumber.clamp(1, 9);
                dataListProvider.visaData.adultsNumber =
                    adultsNumber; // Save adults number

                if (adultsNumber > adultsDetails.length) {
                  adultsDetails.addAll(List<Map<String, dynamic>>.generate(
                    adultsNumber - adultsDetails.length,
                    (_) =>
                        {"title": null, "first_name": null, "last_name": null},
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
                  dataListProvider.visaData.adultsDetails = adultsDetails;
                });
              },
            ),

          CustomTextField(
            label: 'Children number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                childrenNumber = inputNumber.clamp(1, 9);

                dataListProvider.visaData.childrenNumber = childrenNumber;

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
                  dataListProvider.visaData.childrenDetails = childrenDetails;
                });
              },
            ),

          CustomTextField(
            label: 'Note',
            onChanged: (value) {
              setState(() {
                dataListProvider.visaData.note = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
