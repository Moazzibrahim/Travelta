import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/booking_list.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_container_buses.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_container_flight.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_container_hotel.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_container_tour.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_container_visa.dart';

enum BookingListTab { upcoming, current, past }

class BookingListView extends StatefulWidget {
  const BookingListView(
      {super.key,
      this.upcomingBookingList,
      this.currentBookingList,
      this.pastBookingList});
  final UpcomingBookingList? upcomingBookingList;
  final CurrentBookingList? currentBookingList;
  final PastBookingList? pastBookingList;

  @override
  State<BookingListView> createState() => _BookingListViewState();
}

class _BookingListViewState extends State<BookingListView> {
  Map<String, List> bookingList = {};
  BookingListTab? bookingListTab;
  String selectedService = 'Hotel';
  @override
  void initState() {
    if (widget.upcomingBookingList != null) {
      bookingListTab = BookingListTab.upcoming;
    } else if (widget.currentBookingList != null) {
      bookingListTab = BookingListTab.current;
    } else {
      bookingListTab = BookingListTab.past;
    }
    bookingList = {
      'Hotel': bookingListTab == BookingListTab.upcoming
          ? widget.upcomingBookingList!.hotelsBookingList
          : bookingListTab == BookingListTab.current
              ? widget.currentBookingList!.hotelsBookingList
              : widget.pastBookingList!.hotelsBookingList,
      'Visa': bookingListTab == BookingListTab.upcoming
          ? widget.upcomingBookingList!.visasBookingList
          : bookingListTab == BookingListTab.current
              ? widget.currentBookingList!.visasBookingList
              : widget.pastBookingList!.visasBookingList,
      'Bus': bookingListTab == BookingListTab.upcoming
          ? widget.upcomingBookingList!.busBookingList
          : bookingListTab == BookingListTab.current
              ? widget.currentBookingList!.busBookingList
              : widget.pastBookingList!.busBookingList,
      'Flight': bookingListTab == BookingListTab.upcoming
          ? widget.upcomingBookingList!.flightBookingList
          : bookingListTab == BookingListTab.current
              ? widget.currentBookingList!.flightBookingList
              : widget.pastBookingList!.flightBookingList,
      'Tour': bookingListTab == BookingListTab.upcoming
          ? widget.upcomingBookingList!.toursBookingList
          : bookingListTab == BookingListTab.current
              ? widget.currentBookingList!.toursBookingList
              : widget.pastBookingList!.toursBookingList,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                bookingList.keys.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedService = bookingList.keys.toList()[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedService == bookingList.keys.toList()[index]
                            ? mainColor
                            : Colors.blue.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            bookingList.keys.toList()[index],
                            style: TextStyle(
                                color: selectedService ==
                                        bookingList.keys.toList()[index]
                                    ? Colors.white
                                    : mainColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ...List.generate(
              selectedService == 'Hotel'
                  ? bookingList['Hotel']!.length
                  : selectedService == 'Visa'
                      ? bookingList['Visa']!.length
                      : selectedService == 'Bus'
                          ? bookingList['Bus']!.length
                          : selectedService == 'Flight'
                              ? bookingList['Flight']!.length
                              : bookingList['Tour']!.length,
              (index) {
                if (selectedService == 'Hotel') {
                  return BookingListContainerHotel(
                    hotel: bookingList['Hotel']![index],
                    selectedTab: bookingListTab!,
                  );
                } else if (selectedService == 'Visa') {
                  return BookingListContainerVisa(
                    visa: bookingList['Visa']![index],
                    selectedTab: bookingListTab!,
                  );
                } else if (selectedService == 'Bus') {
                  return BookingListContainerBuses(
                    bus: bookingList['Bus']![index],
                    selectedTab: bookingListTab!,
                  );
                } else if (selectedService == 'Flight') {
                  return BookingListContainerFlight(
                      flight: bookingList['Flight']![index],
                      selectedTab: bookingListTab!,
                      );
                } else if (selectedService == 'Tour') {
                  return BookingListContainerTour(
                    tour: bookingList['Tour']![index],
                    selectedTab: bookingListTab!,
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
