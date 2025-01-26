import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details/bus_details_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details/flight_details_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details/hotel_details_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details/tour_details_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details/visa_details_screen.dart';

class DetailsManualBookingScreen extends StatelessWidget {
  final String selectedService;

  const DetailsManualBookingScreen({required this.selectedService, super.key});

  @override
  Widget build(BuildContext context) {
    Widget serviceWidget;

    switch (selectedService) {
      case '1':
        serviceWidget = const VisaWidget();
        break;
      case '2':
        serviceWidget = const FlightWidget();
        break;
      case '3':
        serviceWidget = const HotelWidget();
        break;
      case '4':
        serviceWidget = const TourWidget();
        break;
      case '5':
        serviceWidget = const BusWidget();
        break;
      default:
        serviceWidget = const Center(child: Text('No Service Selected'));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: serviceWidget,
      ),
    );
  }
}
