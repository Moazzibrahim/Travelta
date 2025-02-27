// bus_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/model/manual_booking/bus_model.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  BusDetails busDetails = BusDetails();

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);
    final busDetails = dataListProvider.busDetails;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
            label: 'from',
            onChanged: (value) {
              setState(() {
                busDetails.from = value;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'to',
            onChanged: (value) {
              setState(() {
                busDetails.to = value;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDatePickerTextField(
            label: 'Check in',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('yyyy-MM-dd'),
            onDateSelected: (date) {
              setState(() {
                busDetails.checkInDate = date;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDatePickerTextField(
            label: 'Check out',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('yyyy-MM-dd'),
            onDateSelected: (date) {
              setState(() {
                busDetails.checkOutDate = date;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'Adults number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                adultsNumber = inputNumber.clamp(1, 9);
                busDetails.adultsNumber = adultsNumber;
                if (adultsNumber > adultsDetails.length) {
                  adultsDetails.addAll(List<Map<String, dynamic>>.generate(
                    adultsNumber - adultsDetails.length,
                    (_) =>
                        {"gender": null, "firstName": null, "lastName": null},
                  ));
                } else {
                  adultsDetails.removeRange(adultsNumber, adultsDetails.length);
                }
                dataListProvider.saveBusData(busDetails);
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
                  busDetails.adultsDetails =
                      List.from(adultsDetails); // Save to model
                  dataListProvider.saveBusData(busDetails);
                });
              },
            ),
          CustomTextField(
            label: 'adults price',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                busDetails.adultsPrice = double.parse(value);
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Children number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                childrenNumber = inputNumber.clamp(1, 9);
                busDetails.childrenNumber = childrenNumber;
                if (childrenNumber > childrenDetails.length) {
                  childrenDetails.addAll(List<Map<String, dynamic>>.generate(
                    childrenNumber - childrenDetails.length,
                    (_) => {"age": null},
                  ));
                } else {
                  childrenDetails.removeRange(
                      childrenNumber, childrenDetails.length);
                }
                dataListProvider.saveBusData(busDetails);
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
                  busDetails.childrenDetails = List.from(childrenDetails);
                  dataListProvider.saveBusData(busDetails);
                });
              },
            ),
          CustomTextField(
            label: 'children price',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                busDetails.childrenPrice = double.parse(value);
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'bus name',
            onChanged: (value) {
              setState(() {
                busDetails.busName = value;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'bus number plate',
            onChanged: (value) {
              setState(() {
                busDetails.busNumberPlate = value;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'driver phone',
            onChanged: (value) {
              setState(() {
                busDetails.driverPhone = value;
                dataListProvider.saveBusData(busDetails);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
