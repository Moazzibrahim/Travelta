import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/booking_list/booking_list.dart';
import 'package:flutter_travelta/model/booking_list/booking_list_details.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BookingListController with ChangeNotifier {
  UpcomingBookingList? _upcomingBookingList;
  CurrentBookingList? _currentBookingList;
  PastBookingList? _pastBookingList;

  UpcomingBookingList? get upcomingBookingList => _upcomingBookingList;
  CurrentBookingList? get currentBookingList => _currentBookingList;
  PastBookingList? get pastBookingList => _pastBookingList;

  BookingListDetails? _bookingListDetails;
  BookingListDetails? get bookingListDetails => _bookingListDetails;

  bool isLoaded = false;
  bool isLoadedDetails = false;

  Future<void> fetchBookingList(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final response = await http.get(
        Uri.parse('https://travelta.online/agent/booking'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      );
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        UpcomingBookingList upcomingBookingList = UpcomingBookingList.fromJson(responseData);
        CurrentBookingList currentBookingList = CurrentBookingList.fromJson(responseData);
        PastBookingList pastBookingList = PastBookingList.fromJson(responseData);
        _upcomingBookingList = upcomingBookingList;
        _currentBookingList = currentBookingList;
        _pastBookingList = pastBookingList;
        isLoaded = true;
        notifyListeners();
      }else{
        log('failed to load booking list. Status Code: ${response.statusCode}');
      }
    }catch(e){
      log('Error fetching booking list: $e');
    }
  }

  Future<void> fetchBookingListDetails(BuildContext context,{required int bookingId}) async{
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final response = await http.get(
        Uri.parse('https://travelta.online/agent/booking/details/$bookingId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      );
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        BookingListDetails bookingListDetails = BookingListDetails.fromJson(responseData);
        _bookingListDetails = bookingListDetails;
        isLoadedDetails = true;
        notifyListeners();
      }else{
        log('failed to load booking list details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching booking list details: $e');
    }
  }
}