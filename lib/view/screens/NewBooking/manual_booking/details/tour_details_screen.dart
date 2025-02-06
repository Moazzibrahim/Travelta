// tour_widget.dart

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

  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails = [];
  TourModel tourModel = TourModel();

  void handleRoomTypeChanged(int index, String? value) {
    setState(() {
      selectedRoomTypes[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);
    final TourModel = dataListProvider.tourModel;

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
                adultsNumber = int.tryParse(value) ?? 0;
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
                  tourModel.adultsDetails =
                      List.from(adultsDetails); // Save to model
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
                childrenNumber = int.tryParse(value) ?? 0;
                tourModel.childrenNumber = childrenNumber; // Save to model
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
          const Row(
            children: [
              SectionTitle(title: 'hotel Details'),
            ],
          ),
          CustomTextField(
            label: 'Destination',
            onChanged: (value) {
              setState(() {
                if (tourModel.tourHotels.isEmpty) {
                  tourModel.tourHotels
                      .add({"destination": value}); // Add as a Map
                } else {
                  tourModel.tourHotels[0]["destination"] =
                      value; // Update existing value
                }
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'Hotel Name',
            onChanged: (value) {
              setState(() {
                if (tourModel.tourHotels.isEmpty) {
                  tourModel.tourHotels
                      .add({"hotel_name": value}); // Add as a Map
                } else {
                  tourModel.tourHotels[0]["hotel_name"] =
                      value; // Update existing value
                }
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDatePickerTextField(
            label: 'Check in',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('dd/MM/yyyy'),
            onDateSelected: (date) {
              setState(() {
                if (tourModel.tourHotels.isEmpty) {
                  tourModel.tourHotels
                      .add({"check_in": date.toString()}); // Add as a Map
                } else {
                  tourModel.tourHotels[0]["check_in"] =
                      date.toString(); // Update existing value
                }
                dataListProvider.saveTourData(tourModel);
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
                if (tourModel.tourHotels.isEmpty) {
                  tourModel.tourHotels
                      .add({"check_out": date.toString()}); // Add as a Map
                } else {
                  tourModel.tourHotels[0]["check_out"] =
                      date.toString(); // Update existing value
                }
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: 'number of night',
            onChanged: (value) {
              setState(() {
                if (tourModel.tourHotels.isEmpty) {
                  tourModel.tourHotels.add({"nights": value});
                } else {
                  tourModel.tourHotels[0]["nights"] = value;
                }
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropdownField(
            label: 'select room type:',
            items: const [
              DropdownMenuItem(
                  value: 'first class', child: Text('first class')),
              DropdownMenuItem(value: 'double', child: Text('double')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  if (tourModel.tourHotels.isEmpty) {
                    tourModel.tourHotels.add({"room_type": value});
                  } else {
                    tourModel.tourHotels[0]["room_type"] = value;
                  }
                  dataListProvider.saveTourData(tourModel);
                });
              }
            },
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
            label: 'Select tour transportation:',
            items: const [
              DropdownMenuItem(value: 'domestic', child: Text('Domestic')),
              DropdownMenuItem(
                  value: 'international', child: Text('International')),
            ],
            onChanged: (value) {
              setState(() {
                if (tourModel.tourBuses.isEmpty) {
                  tourModel.tourBuses
                      .add({"transportation": value}); // Add as a Map
                } else {
                  tourModel.tourBuses[0]["transportation"] =
                      value; // Update existing value
                }
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
          CustomTextField(
            label: 'Number of seats',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                if (tourModel.tourBuses.isEmpty) {
                  tourModel.tourBuses.add({"seats": int.tryParse(value) ?? 0});
                } else {
                  tourModel.tourBuses[0]["seats"] = int.tryParse(value) ?? 0;
                }
                dataListProvider.saveTourData(tourModel);
              });
            },
          ),
        ],
      ),
    );
  }
}
