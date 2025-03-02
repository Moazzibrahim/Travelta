import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details_manual_booking_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/from_manual_booking_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/to_manual_booking_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/widgets/stepper_widget.dart';
import 'package:provider/provider.dart';

class ManualBookingScreen extends StatefulWidget {
  const ManualBookingScreen({super.key});

  @override
  State<ManualBookingScreen> createState() => _ManualBookingScreenState();
}

class _ManualBookingScreenState extends State<ManualBookingScreen> {
  late PageController _pageController;
  late int currentIndex;
  String selectedService = '';

  final List<StepData> steps = [
    StepData(
      label: "From",
      screen: FromManualBookingScreen(
        // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
        onServiceSelected: (String) {},
      ),
    ),
    StepData(label: "To", screen: const ToManualBookingScreen()),
    StepData(label: "Details", screen: const SizedBox()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    currentIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  void _onStepTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (currentIndex < steps.length - 1) {
      setState(() {
        currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Manual Booking"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StepperRow(
              steps: steps,
              currentIndex: currentIndex,
              onStepTapped: _onStepTapped,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: [
                  FromManualBookingScreen(onServiceSelected: _updateService),
                  const ToManualBookingScreen(),
                  DetailsManualBookingScreen(selectedService: selectedService),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentIndex > 0 ? _onPrevious : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentIndex > 0 ? mainColor : Colors.grey,
                  ),
                  child: const Text(
                    "Previous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: currentIndex < steps.length - 1
                      ? _onNext
                      : _onBookPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                  ),
                  child: Text(
                    currentIndex < steps.length - 1 ? "Next" : "Book",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onBookPressed() async {
    final dataListProvider =
        Provider.of<DataListProvider>(context, listen: false);

    Map<String, dynamic> bookingData = {};

    if (selectedService == '2') {
      bookingData = {
        'type': dataListProvider.flightDetails.flightType,
        'direction': dataListProvider.flightDetails.flightDirection,
        'departure': dataListProvider.flightDetails.checkInDate,
        'arrival':
            dataListProvider.flightDetails.arrivalDate?.toIso8601String(),
        'childreen': dataListProvider.flightDetails.childrenNumber,
        'adults': dataListProvider.flightDetails.adultsNumber,
        'infants': dataListProvider.flightDetails.infantNumber,
        'adult_price': dataListProvider.flightDetails.adultsPrice,
        'child_price': dataListProvider.flightDetails.childrenPrice,
        'adults_data': dataListProvider.flightDetails.adultsDetails,
        'children_data': dataListProvider.flightDetails.childrenDetails,
        'from_to': dataListProvider.flightDetails.fromto,
        'class': dataListProvider.flightDetails.flightClass,
        'airline': dataListProvider.flightDetails.airline,
        'ticket_number': dataListProvider.flightDetails.ticketNumber,
        'ref_pnr': dataListProvider.flightDetails.refBNR,
      };
    } else if (selectedService == '1') {
      bookingData = {
        'country': dataListProvider.visaData.country,
        'travel_date': dataListProvider.visaData.dateOfTravel,
        'appointment_date': dataListProvider.visaData.returnDate,
        'notes': dataListProvider.visaData.note,
        'adults': dataListProvider.visaData.adultsNumber,
        'childreen': dataListProvider.visaData.childrenNumber,
        'adults_data': dataListProvider.visaData.adultsDetails,
        'children_data': dataListProvider.visaData.childrenDetails,
      };
    } else if (selectedService == '4') {
      bookingData = {
        'tour': dataListProvider.tourModel.tourName,
        'type': dataListProvider.tourModel.tourType,
        'adult_price': dataListProvider.tourModel.adultsPrice,
        'child_price': dataListProvider.tourModel.childrenPrice,
        'adults': dataListProvider.tourModel.adultsNumber,
        'childreen': dataListProvider.tourModel.childrenNumber,
        'tour_buses': dataListProvider.tourModel.tourBuses,
        'tour_hotels': dataListProvider.tourModel.tourHotels,
        'adults_data': dataListProvider.tourModel.adultsDetails,
        'children_data': dataListProvider.tourModel.childrenDetails,
      };
    } else if (selectedService == '5') {
      bookingData = {
        'from': dataListProvider.busDetails.from,
        'to': dataListProvider.busDetails.to,
        'departure': dataListProvider.busDetails.checkInDate,
        'arrival': dataListProvider.busDetails.checkOutDate,
        'adults': dataListProvider.busDetails.adultsNumber,
        'childreen': dataListProvider.busDetails.childrenNumber,
        'adult_price': dataListProvider.busDetails.adultsPrice,
        'child_price': dataListProvider.busDetails.childrenPrice,
        'bus': dataListProvider.busDetails.busName,
        'bus_number': dataListProvider.busDetails.busNumberPlate,
        'driver_phone': dataListProvider.busDetails.driverPhone,
        'adults_data': dataListProvider.busDetails.adultsDetails,
        'children_data': dataListProvider.busDetails.childrenDetails,
      };
    } else if (selectedService == '3') {
      bookingData = {
        'check_in': dataListProvider.hotelData.checkInDate,
        'check_out': dataListProvider.hotelData.checkOutDate,
        'nights': dataListProvider.hotelData.totalNights,
        'hotel_name': dataListProvider.hotelData.hotelName,
        'room_type': dataListProvider.hotelData.selectedRoomTypes,
        'room_quantity': dataListProvider.hotelData.roomQuantity,
        'adults': dataListProvider.hotelData.adultsNumber,
        'childreen': dataListProvider.hotelData.childrenNumber,
        'adults_data': dataListProvider.hotelData.adultsDetails,
        'children_data': dataListProvider.hotelData.childrenDetails,
      };
    }

    bookingData.addAll({
      'to_customer_id': dataListProvider.manualBookingData.selectedtoCustomerId,
      'to_supplier_id': dataListProvider.manualBookingData.selectedtoSupplierId,
      'from_supplier_id':
          dataListProvider.manualBookingData.fromselectedSupplierId,
      'from_service_id': dataListProvider.manualBookingData.selectedServiceId,
      'cost': dataListProvider.manualBookingData.cost,
      'price': dataListProvider.manualBookingData.cost +
          dataListProvider.manualBookingData.markupValue,
      'currency_id': dataListProvider.manualBookingData.selectedCurrencyId,
      'tax_type': dataListProvider.manualBookingData.selectedTaxType,
      'taxes': dataListProvider.manualBookingData.selectedTaxId,
      'total_price': dataListProvider.manualBookingData.finalPrice,
      'country_id': dataListProvider.manualBookingData.selectedCountryId,
      'city_id': dataListProvider.manualBookingData.selectedCityId,
      'mark_up': dataListProvider.manualBookingData.markupValue,
      'mark_up_type': dataListProvider.manualBookingData.selectedMarkup,
      'agent_sales_id': dataListProvider.manualBookingData.selectedEmployeeId,
      'special_request': dataListProvider.manualBookingData.spicalRequest,
    });
    log(dataListProvider.flightDetails.fromto.toString());

    try {
      await dataListProvider.sendBookingData(context, bookingData);
      dataListProvider.clearBookingData();
    } catch (error) {
      log("Error booking: $error");
    }
  }
}
