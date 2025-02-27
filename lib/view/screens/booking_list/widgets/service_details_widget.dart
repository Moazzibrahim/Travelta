import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/bus_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/flight_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/hotel_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/tour_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/visa_booking_list.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/bus_main_container.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/flight_main_widget.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/service_container.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/tour_main_widget.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/visa_main_container.dart';

class ServiceDetailsWidget extends StatefulWidget {
  const ServiceDetailsWidget(
      {super.key,
      required this.type,
      this.hotelBookingList,
      this.visa,
      this.bus,
      this.flight,
      this.tour,
      });
  final String type;
  final HotelBookingList? hotelBookingList;
  final Visa? visa;
  final BusBookingList? bus;
  final Flight? flight;
  final Tour? tour;

  @override
  State<ServiceDetailsWidget> createState() => _ServiceDetailsWidgetState();
}

class _ServiceDetailsWidgetState extends State<ServiceDetailsWidget> {
  String? name;
  int? numOfAdults;
  int? numOfChildren;
  @override
  void initState() {
    if(widget.hotelBookingList != null){
      name = widget.hotelBookingList!.name;
      numOfAdults = widget.hotelBookingList!.numOfAdults;
      numOfChildren = widget.hotelBookingList!.numOfChildren;
    }else if(widget.visa != null){
      name = widget.visa!.toName;
      numOfAdults = widget.visa!.noAdults;
      numOfChildren = widget.visa!.noChildren;
    }else if(widget.bus != null){
      name = widget.bus!.name;
      numOfAdults = widget.bus!.numOfAdults;
      numOfChildren = widget.bus!.numOfChildren;
    }else if(widget.flight != null){
      name = widget.flight!.toName;
      numOfAdults = widget.flight!.adultsNo;
      numOfChildren = widget.flight!.childrenNo;
    }else if(widget.tour != null){
      name = widget.tour!.tourName;
      numOfAdults = widget.tour!.adultsNo;
      numOfChildren = widget.tour!.childrenNo;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.type} Service',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: mainColor),
        ),
        const SizedBox(height: 16),
        widget.hotelBookingList != null
            ? ServiceContainer(
                name: name!,
                type: widget.type,
                roomType:
                    widget.hotelBookingList?.roomType.map((x) => x).join(',') ??
                        '',
                numOfRooms: widget.hotelBookingList?.roomType.length,
              )
            : widget.visa != null
                ? VisaMainContainer(
                    type: widget.type,
                    appointmentDate: widget.visa!.appointment,
                    travelDate: widget.visa!.appointment,
                  )
                : widget.bus != null
                    ? BusMainContainer(
                        type: widget.type,
                        from: widget.bus!.from,
                        to: widget.bus!.to,
                        driverPhone: widget.bus!.driverPhone,
                      )
                    : widget.flight != null? FlightMainWidget(
                        type: widget.type,
                        from: widget.flight!.fromTo[0]['from']!,
                        to: widget.flight!.fromTo[0]['to']!,
                        flightType: widget.flight!.flightType,
                        ) : TourMainWidget(
                          destination: widget.tour!.tourHotels.map((e) => e.destination,).join(','),
                          hotelName: widget.tour!.tourHotels.map((e) => e.hotelName,).join(','),
                          seats: widget.tour!.tourBuses.map((e) => e.seats.toString(),).join(','),
                          tourName: name!,
                          tourType: widget.tour!.tourType,
                          transporation: widget.tour!.tourBuses.map((e) => e.transportation,).join(','),
                          type: widget.type,
                        ),
        const SizedBox(height: 16),
        widget.hotelBookingList != null || widget.bus != null || widget.flight != null
            ? Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.17,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/calendar-edit.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.bus != null || widget.flight != null
                                ? 'Departure & Arrival Details'
                                : 'CheckIn & CheckOut Details',
                            style: TextStyle(fontSize: 20, color: mainColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.bus != null || widget.flight != null
                                ? 'Departure Date: '
                                : 'CheckIn Date: ',
                            style: TextStyle(color: mainColor, fontSize: 16),
                          ),
                          Text(
                            widget.bus != null || widget.flight != null
                                ? widget.flight == null?  widget.bus!.departure : widget.flight!.departure
                                : widget.hotelBookingList!.checkIn,
                            style: TextStyle(color: mainColor, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.bus != null
                                  ? 'Arrival Date: '
                                  : 'CheckOut Date: ',
                              style: TextStyle(color: mainColor, fontSize: 16),
                            ),
                            Text(
                              widget.bus != null
                                  ? widget.flight == null  ? widget.bus!.arrival! : widget.flight!.arrival!
                                  : widget.hotelBookingList!.checkOut,
                              style: TextStyle(color: mainColor, fontSize: 16),
                            ),
                          ])
                    ]),
              )
            : const SizedBox(),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.17,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/guests_information.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Guests information',
                      style: TextStyle(fontSize: 20, color: mainColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Adults: ',
                      style: TextStyle(color: mainColor, fontSize: 16),
                    ),
                    Text(
                      numOfAdults.toString(),
                      style: TextStyle(color: mainColor, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Children: ',
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                      Text(
                        numOfChildren.toString(),
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                    ])
              ]),
        ),
      ],
    );
  }
}
