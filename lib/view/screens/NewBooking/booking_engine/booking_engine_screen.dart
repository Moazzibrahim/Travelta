import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/hotel/hotel_booking_engine.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/tour_booking_engine.dart';
import 'package:provider/provider.dart';

class BookingEngineScreen extends StatefulWidget {
  const BookingEngineScreen({super.key});

  @override
  State<BookingEngineScreen> createState() => _BookingEngineScreenState();
}

class _BookingEngineScreenState extends State<BookingEngineScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchCountries(context);
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchCities(context);
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchHotels(context);
    Provider.of<BookingEngineController>(context, listen: false)
        .fetchNationalities(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Engine'),
          bottom: TabBar(
            labelColor: mainColor,
            indicatorColor: mainColor,
            tabs: const [
              Tab(text: "Hotel"),
              Tab(text: "Tour"),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: const TabBarView(
          children: [HotelBookingTab(), TourBookingTab()],
        ),
      ),
    );
  }
}
