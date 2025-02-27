import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/model/manual_booking/tour_model.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  List<TourHotel> tourHotels = [];
  List<TourBus> tourBuses = [];

  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails = [];
  TourModel tourModel = TourModel();

  void handleRoomTypeChanged(int index, String? value) {
    setState(() {
      selectedRoomTypes[index] = value;
    });
  }

  @override
  void initState() {
    super.initState();

    tourHotels = List.generate(
      1,
      (index) => TourHotel(
        destination: "Destination ${index + 1}",
        hotelName: "Hotel ${index + 1}",
        roomType: roomTypes[index % roomTypes.length],
        checkIn: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        checkOut: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: index + 1))),
        nights: index + 1,
      ),
    );
    tourBuses = List.generate(
      1,
      (index) => TourBus(
        transportation: "Bus ${index + 1}",
        seats: index + 1,
      ),
    );

    selectedRoomTypes.addAll(tourHotels.map((hotel) => hotel.roomType));
  }

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);
    tourModel = dataListProvider.tourModel;

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
          CustomTextField(
            label: 'Tour Name',
            onChanged: (value) {
              setState(() {
                tourModel.tourName = value;
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDropdownField(
            label: 'select  tour type:',
            items: const [
              DropdownMenuItem(value: 'domestic', child: Text('domestic')),
              DropdownMenuItem(
                  value: 'international', child: Text('international')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  tourModel.tourType = value;
                  dataListProvider.saveTourData(tourModel);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Adults number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                adultsNumber = inputNumber.clamp(1, 9);
                tourModel.adultsNumber = adultsNumber;
                if (adultsNumber > adultsDetails.length) {
                  adultsDetails.addAll(List<Map<String, dynamic>>.generate(
                    adultsNumber - adultsDetails.length,
                    (_) =>
                        {"gender": null, "firstName": null, "lastName": null},
                  ));
                } else {
                  adultsDetails.removeRange(adultsNumber, adultsDetails.length);
                }
                dataListProvider.saveTourData(tourModel);
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
                  tourModel.adultsDetails = List.from(adultsDetails);
                  dataListProvider.saveTourData(tourModel);
                });
              },
            ),
          CustomTextField(
            label: 'adults price',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                tourModel.adultsPrice = value;
                dataListProvider.saveTourData(tourModel);
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

                tourModel.childrenNumber = childrenNumber;
                if (childrenNumber > childrenDetails.length) {
                  childrenDetails.addAll(List<Map<String, dynamic>>.generate(
                    childrenNumber - childrenDetails.length,
                    (_) => {"age": null},
                  ));
                } else {
                  childrenDetails.removeRange(
                      childrenNumber, childrenDetails.length);
                }
                dataListProvider.saveTourData(tourModel);
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
                  tourModel.childrenDetails = List.from(childrenDetails);
                  dataListProvider.saveTourData(tourModel);
                });
              },
            ),
          CustomTextField(
            label: 'children price',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                tourModel.childrenPrice = value;
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SectionTitle(title: 'Hotel Details'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              label: 'Destination',
              onChanged: (value) {
                setState(() {
                  tourHotels[0].destination = value;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'Hotel Name',
            onChanged: (value) {
              setState(() {
                tourHotels[0].hotelName = value;
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
                tourHotels[0].checkIn = date.toString();
                log(tourHotels[0].checkIn.toString());
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
                tourHotels[0].checkOut = date.toString();
                log(tourHotels[0].checkOut.toString());
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'Number of Nights',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                tourHotels[0].nights = int.tryParse(value) ?? 0;
                tourModel.tourHotels = tourHotels;
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SectionTitle(title: 'Transportation Details'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDropdownField(
            label: 'Select Transportation',
            items: const [
              DropdownMenuItem(value: 'Bus', child: Text('Bus')),
              DropdownMenuItem(value: 'Flight', child: Text('Flight')),
            ],
            onChanged: (value) {
              setState(() {
                tourHotels[0].destination = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'Number of Seats',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                tourBuses[0].seats = int.tryParse(value) ?? 0;
                tourModel.tourBuses = tourBuses;
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
        ],
      ),
    );
  }
}
