
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/widgets/auto_complete_widget.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class HotelBookingTab extends StatefulWidget {
  const HotelBookingTab({super.key});

  @override
  State<HotelBookingTab> createState() => _HotelBookingTabState();
}

class _HotelBookingTabState extends State<HotelBookingTab> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _adultsCount = 1;
  int _childrenCount = 0;
  String? selectedType;
  int? selectedCountryId;
  int? selectedCityId;
  int? selectedHotelId;
  String typedText = '';

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: mainColor),
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
            ...bookingEngineProvider.hotels.map((hotel) => {
                  'id': hotel.id,
                  'name': hotel.name,
                  'type': 'Hotel',
                  'icon': Icons.hotel
                }),
          ];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoCompleteWidget(
                    hintText: 'Search for City, Country or Hotel',
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
                    onChange: (value) => setState(() => typedText = value),
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(context, "Check-In Date", _checkInDate,
                      () => _selectDate(context, true)),
                  const SizedBox(height: 16),
                  _buildDateField(context, "Check-Out Date", _checkOutDate,
                      () => _selectDate(context, false)),
                  const SizedBox(height: 16),
                  _buildCountRow(
                      "Adults",
                      _adultsCount,
                      () => _updateCount(true, false),
                      () => _updateCount(true, true)),
                  const SizedBox(height: 16),
                  _buildCountRow(
                      "Children",
                      _childrenCount,
                      () => _updateCount(false, false),
                      () => _updateCount(false, true)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      onPressed: () {
                        if ((selectedCityId == null &&
                                selectedCountryId == null &&
                                selectedHotelId == null &&
                                typedText.isEmpty) ||
                            _checkInDate == null ||
                            _checkOutDate == null) {
                          showCustomSnackBar(context, 'Please fill all fields');
                          return;
                        }

                        bookingEngineProvider.postBooking(
                          context,
                          checkIn:
                              "${_checkInDate!.year}-${_checkInDate!.month}-${_checkInDate!.day}",
                          checkOut:
                              "${_checkOutDate!.year}-${_checkOutDate!.month}-${_checkOutDate!.day}",
                          maxAdults: _adultsCount,
                          maxChildren: _childrenCount,
                          cityId: selectedCityId,
                          countryId: selectedCountryId,
                          hotelId: selectedHotelId,
                        );
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

  Widget _buildDateField(
      BuildContext context, String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(
              text:
                  date != null ? "${date.day}/${date.month}/${date.year}" : ''),
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: Icon(Icons.calendar_month, color: mainColor),
              border: const OutlineInputBorder()),
        ),
      ),
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
