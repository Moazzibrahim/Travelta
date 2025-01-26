import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class HotelWidget extends StatefulWidget {
  const HotelWidget({super.key});

  @override
  HotelWidgetState createState() => HotelWidgetState();
}

class HotelWidgetState extends State<HotelWidget> {
  int roomQuantity = 0;
  int adultsNumber = 0;
  int childrenNumber = 0; // Added children number field
  final List<String> roomTypes = ["Single", "Double", "Suite", "Deluxe"];
  final List<String?> selectedRoomTypes = [];
  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails =
      []; // List to store children details

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
              SectionTitle(title: 'Hotel Details'),
            ],
          ),
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
          const CustomTextField(label: 'Hotel Address'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(
            label: 'Total night',
            isNumeric: true,
          ),
          const SizedBox(
            height: 10,
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

          const SizedBox(height: 20),
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
        ],
      ),
    );
  }
}
