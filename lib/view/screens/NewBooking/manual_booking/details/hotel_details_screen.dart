import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/model/manual_booking/hotel_model.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HotelWidget extends StatefulWidget {
  const HotelWidget({super.key});

  @override
  HotelWidgetState createState() => HotelWidgetState();
}

class HotelWidgetState extends State<HotelWidget> {
  int roomQuantity = 0;
  int adultsNumber = 0;
  int childrenNumber = 0;
  final List<String> roomTypes = ["Single", "Double", "Suite", "Deluxe"];
  List<String?> selectedRoomTypes = [];
  List<Map<String, dynamic>> adultsDetails = [];
  List<Map<String, dynamic>> childrenDetails = [];

  HotelModel hotelModel = HotelModel();

  void handleRoomTypeChanged(int index, String? value) {
    setState(() {
      selectedRoomTypes[index] = value;
      hotelModel.selectedRoomTypes = List.from(selectedRoomTypes);
    });
  }

  void handleAdultDetailChanged(int index, String key, dynamic value) {
    setState(() {
      adultsDetails[index][key] = value;
      hotelModel.adultsDetails = List.from(adultsDetails);
      Provider.of<DataListProvider>(context, listen: false)
          .saveHotelData(hotelModel);
    });
  }

  void handleChildDetailChanged(int index, String key, dynamic value) {
    setState(() {
      childrenDetails[index][key] = value;
      hotelModel.childrenDetails = List.from(childrenDetails);
      Provider.of<DataListProvider>(context, listen: false)
          .saveHotelData(hotelModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);
    final HotelModel = dataListProvider.hotelData;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              SectionTitle(title: 'Hotel Details'),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Hotel Name',
            onChanged: (value) {
              setState(() {
                hotelModel.hotelName = value;
                dataListProvider.saveHotelData(hotelModel);
              });
            },
          ),
          const SizedBox(height: 10),
          CustomDatePickerTextField(
            label: 'Check in',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('dd/MM/yyyy'),
            onDateSelected: (date) {
              setState(() {
                hotelModel.checkInDate = date;
                dataListProvider.saveHotelData(hotelModel);
              });
            },
          ),
          const SizedBox(height: 10),
          CustomDatePickerTextField(
            label: 'Check out',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('dd/MM/yyyy'),
            onDateSelected: (date) {
              setState(() {
                hotelModel.checkOutDate = date;
                dataListProvider.saveHotelData(hotelModel);
              });
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Total night',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                hotelModel.totalNights = int.tryParse(value);
                dataListProvider.saveHotelData(hotelModel);
              });
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Room quantity',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                roomQuantity = int.tryParse(value) ?? 0;
                hotelModel.roomQuantity = roomQuantity;

                if (roomQuantity > selectedRoomTypes.length) {
                  selectedRoomTypes.addAll(List<String?>.filled(
                      roomQuantity - selectedRoomTypes.length, null));
                } else if (roomQuantity < selectedRoomTypes.length) {
                  selectedRoomTypes =
                      selectedRoomTypes.sublist(0, roomQuantity);
                }
                hotelModel.selectedRoomTypes = List.from(selectedRoomTypes);
              });
            },
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
                hotelModel.adultsNumber = adultsNumber;

                if (adultsNumber > adultsDetails.length) {
                  adultsDetails.addAll(List.generate(
                    adultsNumber - adultsDetails.length,
                    (_) =>
                        {"gender": null, "firstName": null, "lastName": null},
                  ));
                } else if (adultsNumber < adultsDetails.length) {
                  adultsDetails = adultsDetails.sublist(0, adultsNumber);
                }
                hotelModel.adultsDetails = List.from(adultsDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          if (adultsNumber > 0)
            AdultDetailsList(
              count: adultsNumber,
              details: adultsDetails,
              onDetailChanged: handleAdultDetailChanged,
            ),
          CustomTextField(
            label: 'Children number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                childrenNumber = int.tryParse(value) ?? 0;
                hotelModel.childrenNumber = childrenNumber;

                if (childrenNumber > childrenDetails.length) {
                  childrenDetails.addAll(List.generate(
                    childrenNumber - childrenDetails.length,
                    (_) => {"age": null},
                  ));
                } else if (childrenNumber < childrenDetails.length) {
                  childrenDetails = childrenDetails.sublist(0, childrenNumber);
                }
                hotelModel.childrenDetails = List.from(childrenDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          if (childrenNumber > 0)
            ChildDetailsList(
              count: childrenNumber,
              details: childrenDetails,
              onDetailChanged: handleChildDetailChanged,
            ),
        ],
      ),
    );
  }
}
