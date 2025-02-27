import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/screens/NewBooking/result_booking_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/view/widgets/auto_complete_widget.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class BookingEngineScreen extends StatefulWidget {
  const BookingEngineScreen({super.key});

  @override
  State<BookingEngineScreen> createState() => _BookingEngineScreenState();
}

class _BookingEngineScreenState extends State<BookingEngineScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _adultsCount = 1;
  int _childrenCount = 0;
  String? selectedType;
  List<Map<String, dynamic>> recentSearches = [];
  int? selectedCountryId;
  int? selectedCityId;
  int? selectedHotelId;
  String typedText = '';

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: mainColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = pickedDate;
        } else {
          _checkOutDate = pickedDate;
        }
      });
    }
  }

  void _updateCount(bool isAdult, bool isIncrement) {
    setState(() {
      if (isAdult) {
        if (isIncrement) {
          _adultsCount++;
        } else if (_adultsCount > 1) {
          _adultsCount--;
        }
      } else {
        if (isIncrement) {
          _childrenCount++;
        } else if (_childrenCount > 0) {
          _childrenCount--;
        }
      }
    });
  }

  @override
  void initState() {
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchCountries(context);
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchCities(context);
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchHotels(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Booking Engine'),
      body: Consumer<BookingEngineController>(
        builder: (context, bookingEngineProvider, _) {
          if (bookingEngineProvider.isHotelsEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            );
          } else {
            final List<Map<String, dynamic>> destinations = [
              ...bookingEngineProvider.cities.map((city) => {
                    'id': city.id,
                    'name': city.name,
                    'type': 'City',
                    'icon': Icons.location_city,
                  }),
              ...bookingEngineProvider.countries.map((country) => {
                    'id': country.id,
                    'name': country.name,
                    'type': 'Country',
                    'icon': Icons.flag,
                  }),
              ...bookingEngineProvider.hotels.map((hotel) => {
                    'id': hotel.id,
                    'name': hotel.name,
                    'type': 'Hotel',
                    'icon': Icons.hotel,
                  }),
            ];
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoCompleteWidget(
                              hintText: 'search for City,Country or Hotel',
                              options: destinations,
                              onSelected: (value) {
                                log('${value['type']}');
                                setState(() {
                                  selectedType = value['type'];
                                  if (selectedType == 'City') {
                                    selectedCityId = value['id'];
                                  } else if (selectedType == 'Country') {
                                    selectedCountryId = value['id'];
                                  } else if (selectedType == 'Hotel') {
                                    selectedHotelId = value['id'];
                                  }
                                });
                              },
                              onChange: (value) {
                                setState(() {
                                  typedText = value;
                                });
                              }),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: TextEditingController(
                                  text: _checkInDate != null
                                      ? "${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}"
                                      : '',
                                ),
                                decoration: InputDecoration(
                                  labelText: "Check-In Date",
                                  suffixIcon: Icon(Icons.calendar_month_sharp,
                                      color: mainColor),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: TextEditingController(
                                  text: _checkOutDate != null
                                      ? "${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}"
                                      : '',
                                ),
                                decoration: InputDecoration(
                                  labelText: "Check-Out Date",
                                  suffixIcon: Icon(Icons.calendar_month_sharp,
                                      color: mainColor),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Adults:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: mainColor),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle,
                                            color: mainColor),
                                        onPressed: () =>
                                            _updateCount(true, false),
                                      ),
                                      Text("$_adultsCount",
                                          style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: Icon(Icons.add_circle,
                                            color: mainColor),
                                        onPressed: () =>
                                            _updateCount(true, true),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Child:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: mainColor),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle,
                                            color: mainColor),
                                        onPressed: () =>
                                            _updateCount(false, false),
                                      ),
                                      Text("$_childrenCount",
                                          style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: Icon(Icons.add_circle,
                                            color: mainColor),
                                        onPressed: () =>
                                            _updateCount(false, true),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (selectedCityId == null &&
                                selectedCountryId == null &&
                                selectedHotelId == null &&
                                typedText.isEmpty ||
                            _checkInDate == null ||
                            _checkOutDate == null) {
                          showCustomSnackBar(context, 'Please fill all fields');
                          return;
                        }
                        if (selectedCityId == null &&
                            selectedCountryId == null &&
                            selectedHotelId == null &&
                            typedText.isNotEmpty) {
                          final match = destinations.firstWhere(
                            (item) => item['name']
                                .toLowerCase()
                                .startsWith(typedText.toLowerCase()),
                            orElse: () => {},
                          );

                          if (match.isNotEmpty) {
                            selectedType = match['type'];
                            if (selectedType == 'City') {
                              selectedCityId = match['id'];
                            } else if (selectedType == 'Country') {
                              selectedCountryId = match['id'];
                            } else if (selectedType == 'Hotel') {
                              selectedHotelId = match['id'];
                            }
                          }
                        }

                        bookingEngineProvider.postBooking(
                          context,
                          checkIn:
                              "${_checkInDate!.year}-${_checkInDate!.month}-${_checkInDate!.day}",
                          checkOut:
                              "${_checkOutDate!.year}-${_checkOutDate!.month}-${_checkOutDate!.day}",
                          maxAdults: _adultsCount,
                          maxChildren: _childrenCount,
                          countryId: selectedCountryId,
                          cityId: selectedCityId,
                          hotelId: selectedHotelId,
                        );

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const ResultBookingScreen()));
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
