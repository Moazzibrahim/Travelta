import 'package:flutter_travelta/model/booking_list/bus_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/flight_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/hotel_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/tour_booking_list.dart';
import 'package:flutter_travelta/model/booking_list/visa_booking_list.dart';

class UpcomingBookingList {
  final List<HotelBookingList> hotelsBookingList;
  final List<BusBookingList> busBookingList;
  final List<Flight> flightBookingList;
  final List<Visa> visasBookingList;
  final List<Tour> toursBookingList;

  UpcomingBookingList({
    required this.hotelsBookingList,
    required this.busBookingList,
    required this.flightBookingList,
    required this.visasBookingList,
    required this.toursBookingList,
  });

  factory UpcomingBookingList.fromJson(Map<String, dynamic> json) =>
      UpcomingBookingList(
        hotelsBookingList: List<HotelBookingList>.from(
            json['upcoming']['hotels'].map((x) => HotelBookingList.fromJson(x))),
        busBookingList: List<BusBookingList>.from(
            json['upcoming']['buses'].map((x) => BusBookingList.fromJson(x))),
        flightBookingList: List<Flight>.from(
            json['upcoming']['flights'].map((x) => Flight.fromJson(x))),
        visasBookingList: List<Visa>.from(
            json['upcoming']['visas'].map((x) => Visa.fromJson(x))),        
        toursBookingList: List<Tour>.from(
            json['upcoming']['tours'].map((x) => Tour.fromJson(x))),        
      );
}

class CurrentBookingList {
  final List<HotelBookingList> hotelsBookingList;
  final List<BusBookingList> busBookingList;
  final List<Flight> flightBookingList;
  final List<Visa> visasBookingList;
  final List<Tour> toursBookingList;

  CurrentBookingList({
    required this.hotelsBookingList,
    required this.busBookingList,
    required this.flightBookingList,
    required this.visasBookingList,
    required this.toursBookingList,
  });

  factory CurrentBookingList.fromJson(Map<String, dynamic> json) =>
      CurrentBookingList(
        hotelsBookingList: List<HotelBookingList>.from(
            json['current']['hotels'].map((x) => HotelBookingList.fromJson(x))),
        busBookingList: List<BusBookingList>.from(
            json['current']['buses'].map((x) => BusBookingList.fromJson(x))),
        flightBookingList: List<Flight>.from(
            json['current']['flights'].map((x) => Flight.fromJson(x))),
        visasBookingList: List<Visa>.from(
            json['current']['visas'].map((x) => Visa.fromJson(x))),        
        toursBookingList: List<Tour>.from(
            json['current']['tours'].map((x) => Tour.fromJson(x))),        
      );
}

class PastBookingList {
  final List<HotelBookingList> hotelsBookingList;
  final List<BusBookingList> busBookingList;
  final List<Flight> flightBookingList;
  final List<Visa> visasBookingList;
  final List<Tour> toursBookingList;

  PastBookingList({
    required this.hotelsBookingList,
    required this.busBookingList,
    required this.flightBookingList,
    required this.visasBookingList,
    required this.toursBookingList,
  });

  factory PastBookingList.fromJson(Map<String, dynamic> json) =>
      PastBookingList(
        hotelsBookingList: List<HotelBookingList>.from(
            json['past']['hotels'].map((x) => HotelBookingList.fromJson(x))),
        busBookingList: List<BusBookingList>.from(
            json['past']['buses'].map((x) => BusBookingList.fromJson(x))),
        flightBookingList: List<Flight>.from(
            json['past']['flights'].map((x) => Flight.fromJson(x))),
        visasBookingList: List<Visa>.from(
            json['past']['visas'].map((x) => Visa.fromJson(x))),        
        toursBookingList: List<Tour>.from(
            json['past']['tours'].map((x) => Tour.fromJson(x))),        
      );
}






