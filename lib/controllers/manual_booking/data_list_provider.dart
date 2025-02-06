import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/manual_booking/bus_model.dart';
import 'package:flutter_travelta/model/manual_booking/data_list_model.dart';
import 'package:flutter_travelta/model/manual_booking/flight_model.dart';
import 'package:flutter_travelta/model/manual_booking/tour_model.dart';
import 'package:flutter_travelta/model/manual_booking/visa_model.dart';
import 'package:flutter_travelta/view/screens/NewBooking/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/manual_booking/hotel_model.dart';
import '../../model/manual_booking/manual_booking_model.dart';

class DataListProvider extends ChangeNotifier {
  TravelData? _travelData;
  bool _isLoading = false;
  String? _errorMessage;
  ManualBookingData manualBookingData = ManualBookingData();
  HotelModel hotelData = HotelModel();
  VisaBookingData visaData = VisaBookingData();
  BusDetails busDetails = BusDetails();
  FlightDetails flightDetails = FlightDetails();
  TourModel tourModel = TourModel();
  final bool _isSuccess = false;

  TravelData? get travelData => _travelData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  void saveHotelData(HotelModel data) {
    hotelData = data;
    notifyListeners();
  }

  void saveManualBookingData(ManualBookingData data) {
    manualBookingData = data;
    notifyListeners();
  }

  void saveVisaData(VisaBookingData data) {
    visaData = data;
    notifyListeners();
  }

  void saveBusData(BusDetails data) {
    busDetails = data;
    notifyListeners();
  }

  void saveTourData(TourModel data) {
    tourModel = data;
    notifyListeners();
  }

  void saveflight(FlightDetails data) {
    flightDetails = data;
    notifyListeners();
  }

  Future<void> fetchTravelData(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    const String url =
        "https://travelta.online/agent/manual_booking/mobile_lists";

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _travelData = TravelData.fromJson(jsonData);
      } else {
        log(response.statusCode.toString());
        _errorMessage = "Failed to load data: ${response.statusCode}";
      }
    } catch (e) {
      log(e.toString());
      _errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendBookingData(
      BuildContext context, Map<String, dynamic> data) async {
    const String apiUrl = 'https://travelta.online/agent/manual_booking/cart';

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        log('Success: $responseData');

        // Extract cart_id and total
        final int cartId = responseData['cart_id'];
        final double total = double.parse(responseData['total'].toString());

        // Navigate to CartScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartScreen(cartId: cartId, total: total),
          ),
        );
      } else {
        _errorMessage =
            'Failed to send data. Status code: ${response.statusCode}';
        log('Error: ${response.body}');
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      log(_errorMessage.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
