// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/tour_list_screen.dart';
import 'package:flutter_travelta/view/widgets/auto_complete_widget.dart';
import 'package:provider/provider.dart';

class TourBookingTab extends StatefulWidget {
  const TourBookingTab({super.key});

  @override
  State<TourBookingTab> createState() => _TourBookingTabState();
}

class _TourBookingTabState extends State<TourBookingTab> {
  int _adultsCount = 1;
  String? selectedType;
  int? selectedCountryId;
  int? selectedCityId;
  String typedText = '';
  int? selectedTourTypeId;
  int? selectedMonth;
  int? selectedYear;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BookingEngineController>(context, listen: false)
            .fetchTourTypes(context));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingEngineController>(
      builder: (context, bookingEngineProvider, _) {
        if (bookingEngineProvider.isHotelsEmpty) {
          return Center(child: CircularProgressIndicator(color: mainColor));
        } else {
          final List<Map<String, dynamic>> destinations = [
            ...bookingEngineProvider.cities.map((city) => {
                  'id': city.id,
                  'name': city.name,
                  'type': 'City',
                  'icon': Icons.location_city
                }),
            ...bookingEngineProvider.countries.map((country) => {
                  'id': country.id,
                  'name': country.name,
                  'type': 'Country',
                  'icon': Icons.flag
                }),
          ];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTourTypeDropdown(bookingEngineProvider),
                  const SizedBox(height: 16),
                  AutoCompleteWidget(
                    hintText: 'Search for City, Country ',
                    options: destinations,
                    onSelected: (value) {
                      log('${value['type']}');
                      setState(() {
                        selectedType = value['type'];
                        if (selectedType == 'City') {
                          selectedCityId = value['id'];
                        } else if (selectedType == 'Country') {
                          selectedCountryId = value['id'];
                        }
                      });
                    },
                    onChange: (value) => setState(() => typedText = value),
                  ),
                  const SizedBox(height: 16),
                  _buildDatePicker(),
                  const SizedBox(height: 16),
                  _buildCountRow(
                      "Adults",
                      _adultsCount,
                      () => _updateCount(true, false),
                      () => _updateCount(true, true)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      onPressed: () async {
                        if (selectedYear != null &&
                            selectedMonth != null &&
                            selectedTourTypeId != null) {
                          final bookingController =
                              Provider.of<BookingEngineController>(context,
                                  listen: false);

                          final responseData =
                              await bookingController.postTourBooking(
                            context,
                            year: selectedYear!,
                            month: selectedMonth!,
                            people: _adultsCount,
                            destinationCountry: selectedCountryId,
                            destinationCity: selectedCityId,
                            tourTypeId: selectedTourTypeId!,
                          );

                          if (responseData != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TourListScreen(
                                  tourData: responseData,
                                  adultsCount: _adultsCount,
                                ),
                              ),
                            );
                          } else {
                            log("Failed to fetch tour booking data.");
                          }
                        } else {
                          log("Please select all required fields before searching.");
                        }
                      },
                      child: const Text("Search",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _updateCount(bool isAdult, bool isIncrement) {
    setState(() {
      if (isAdult) {
        if (isIncrement) {
          _adultsCount++;
        } else if (_adultsCount > 1) {
          _adultsCount--;
        }
      }
    });
  }

  Widget _buildTourTypeDropdown(BookingEngineController bookingEngineProvider) {
    return DropdownButtonFormField<int>(
      value: selectedTourTypeId,
      decoration: const InputDecoration(
        labelText: "Select Tour Type",
        border: OutlineInputBorder(),
      ),
      items: bookingEngineProvider.tourTypes
          .map((tourType) => DropdownMenuItem<int>(
                value: tourType.id,
                child: Text(tourType.name),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedTourTypeId = value;
          log(selectedTourTypeId.toString());
        });
      },
    );
  }

  Widget _buildDatePicker() {
    List<int> years = List.generate(10, (index) => DateTime.now().year + index);
    List<Map<String, dynamic>> months = List.generate(
        12,
        (index) => {
              'id': index + 1,
              'name': DateTime(0, index + 1)
                  .toLocal()
                  .toString()
                  .split(' ')[0]
                  .split('-')[1] // Month name
            });

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            value: selectedYear,
            decoration: const InputDecoration(
              labelText: "Select Year",
              border: OutlineInputBorder(),
            ),
            items: years
                .map((year) => DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedYear = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<int>(
            value: selectedMonth,
            decoration: const InputDecoration(
              labelText: "Select Month",
              border: OutlineInputBorder(),
            ),
            items: months
                .map((month) => DropdownMenuItem<int>(
                      value: month['id'],
                      child: Text(month['name']),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCountRow(String label, int count, VoidCallback onDecrease,
      VoidCallback onIncrease) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 18)),
      Row(children: [
        IconButton(icon: const Icon(Icons.remove), onPressed: onDecrease),
        Text("$count"),
        IconButton(icon: const Icon(Icons.add), onPressed: onIncrease)
      ])
    ]);
  }
}
