// tour_widget.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class TourWidget extends StatefulWidget {
  const TourWidget({super.key});

  @override
  State<TourWidget> createState() => _TourWidgetState();
}

class _TourWidgetState extends State<TourWidget> {
  int adultsNumber = 0;
  int childrenNumber = 0;
  int roomQuantity = 0;
  final List<String> roomTypes = ["Single", "Double", "Suite", "Deluxe"];
  final List<String?> selectedRoomTypes = [];

  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails = [];

  void handleRoomTypeChanged(int index, String? value) {
    setState(() {
      selectedRoomTypes[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              SectionTitle(title: 'Tour Details'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(label: 'Tour Name'),
          const SizedBox(
            height: 10,
          ),
          CustomDropdownField(
            label: 'select tour type:',
            items: const [
              DropdownMenuItem(value: '1', child: Text('1')),
            ],
            onChanged: (value) {
              log('select tour type: $value');
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
          const Row(
            children: [
              SectionTitle(title: 'hotel Details'),
            ],
          ),
          const CustomTextField(label: 'Destination'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(label: 'Hotel Name'),
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
          const CustomTextField(label: 'number of nights', isNumeric: true),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Room quantity',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                roomQuantity = int.tryParse(value) ?? 0;
                if (roomQuantity > selectedRoomTypes.length) {
                  selectedRoomTypes.addAll(List<String?>.filled(
                      roomQuantity - selectedRoomTypes.length, null));
                } else {
                  selectedRoomTypes.removeRange(
                      roomQuantity, selectedRoomTypes.length);
                }
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          if (roomQuantity > 0)
            RoomDetailsCard(
              roomQuantity: roomQuantity,
              roomTypes: roomTypes,
              selectedRoomTypes: selectedRoomTypes,
              onRoomTypeChanged: handleRoomTypeChanged,
            ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SectionTitle(title: 'transportation Details'),
            ],
          ),
          CustomDropdownField(
            label: 'select tour transportation:',
            items: const [
              DropdownMenuItem(value: '1', child: Text('1')),
            ],
            onChanged: (value) {
              log('select tour transportation: $value');
            },
          ),
          const SizedBox(height: 16),
          const CustomTextField(label: 'number of seats', isNumeric: true),
        ],
      ),
    );
  }
}
