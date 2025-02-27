import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_list_controller.dart';
import 'package:flutter_travelta/model/booking_list/bus_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/flight_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/hotel_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/tour_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/visa_booking_list.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/payments_container.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/service_details_widget.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/service_travelers_widget.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/stepper_widget.dart';
import 'package:provider/provider.dart';

class BookingListDetailsScreen extends StatefulWidget {
  const BookingListDetailsScreen(
      {super.key,
      required this.id,
      required this.type,
      this.hotelBookingList,
      this.visa, this.bus, this.flight, this.tour});
  final int id;
  final String type;
  final HotelBookingList? hotelBookingList;
  final Visa? visa;
  final BusBookingList? bus;
  final Flight? flight;
  final Tour? tour;

  @override
  State<BookingListDetailsScreen> createState() =>
      _BookingListDetailsScreenState();
}

class _BookingListDetailsScreenState extends State<BookingListDetailsScreen> {
  List<String> texts = [
    'details',
    'travelers',
    'specialRequests',
    'confirmationTask',
    'payments',
    'invoice',
    'voucher',
  ];
  String? status;
  String? specialRequest;
  int selectedIndex = 0;
  @override
  void initState() {
    Provider.of<BookingListController>(context, listen: false).fetchBookingListDetails(context, bookingId: widget.id);
    if(widget.bus != null){
      status = widget.bus!.status;
    }else if(widget.visa != null){
      status = widget.visa!.status;
    }else if(widget.hotelBookingList != null){
      status = widget.hotelBookingList!.status;
    }else if(widget.flight != null){
      status = widget.flight!.status;
    }else if(widget.tour != null){
      status = widget.tour!.status;
    }
  if(widget.hotelBookingList != null){
      specialRequest = widget.hotelBookingList!.specialRequest;
    }else if(widget.visa != null){
      specialRequest = widget.visa!.specialRequest;
    }else if(widget.bus != null){
      specialRequest = widget.bus!.specialRequest;
    }else if(widget.flight != null){
      specialRequest = widget.flight!.specialRequest;
    }else if(widget.tour != null){
      specialRequest = widget.tour!.specialRequest;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: mainColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperScreen(
                status: status ?? '',
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(texts.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(16),
                          color: selectedIndex == index
                              ? Colors.blue.shade100
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            texts[index],
                            style: TextStyle(
                                color: selectedIndex == index
                                    ? mainColor
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              selectedIndex == 0
                  ? ServiceDetailsWidget(
                      type: widget.type,
                      hotelBookingList: widget.hotelBookingList,
                      visa: widget.visa,
                      bus: widget.bus,
                      flight: widget.flight,
                      tour: widget.tour,
                    )
                  : selectedIndex == 1
                      ? Consumer<BookingListController>(
                          builder: (context, bookingListProvider, _) {
                            if (!bookingListProvider.isLoadedDetails) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ServiceTravelersWidget(
                                bookingListDetails:
                                    bookingListProvider.bookingListDetails!,
                              );
                            }
                          },
                        )
                      : selectedIndex == 2
                          ? Center(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: MediaQuery.sizeOf(context).width,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  specialRequest ??
                                      'No Special Requests.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: mainColor),
                                ),
                              ),
                            )
                          : selectedIndex == 3
                              ? const Center(
                                  child: Text('confirmation Tasks'),
                                )
                              : selectedIndex == 4
                                  ? Consumer<BookingListController>(
                                      builder:
                                          (context, bookingListProvider, _) {
                                        if (!bookingListProvider.isLoadedDetails) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return PaymentsContainer(
                                            bookingListDetails:
                                                bookingListProvider.bookingListDetails!,
                                          );
                                        }
                                      },
                                    )
                                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
