import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/booking_engine_model.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BookingEngineController with ChangeNotifier {
  List<HotelBooking> _hotels = [];
  List<CountriesBooking> _countries = [];
  List<CitiesBooking> _cities = [];

  List<HotelBooking> get hotels => _hotels;
  List<CountriesBooking> get countries => _countries;
  List<CitiesBooking> get cities => _cities;

  bool get isHotelsEmpty => _hotels.isEmpty;

  List<ResultModel> _results = [];
  List<ResultModel> get results => _results;

  bool get isResultsEmpty => _results.isEmpty;

  bool isLoaded = false;

  Future<void> fetchHotels(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final url = Uri.parse('https://travelta.online/agent/gethotels');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        HotelsBookingList hotels = HotelsBookingList.fromJson(responseData);
        _hotels = hotels.hotels.map((e) => HotelBooking.fromJson(e)).toList();
        notifyListeners();
      } else {
        log('Failed to load hotels. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching hotels: $e');
    }
  }

  Future<void> fetchCountries(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final url = Uri.parse('https://travelta.online/agent/getcountries');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        CountriesBookingList countries =
            CountriesBookingList.fromJson(responseData);
        _countries = countries.countries
            .map((e) => CountriesBooking.fromJson(e))
            .toList();
        notifyListeners();
      } else {
        log('Failed to load countries. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching countries: $e');
    }
  }

  Future<void> fetchCities(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final url = Uri.parse('https://travelta.online/agent/getcities');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        CitiesBookingList cities = CitiesBookingList.fromJson(responseData);
        _cities = cities.cities.map((e) => CitiesBooking.fromJson(e)).toList();
        notifyListeners();
      } else {
        log('Failed to load cities. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching cities: $e');
    }
  }

  Future<void> postBooking(
    BuildContext context, {
    required String checkIn,
    required String checkOut,
    required int maxAdults,
    required int maxChildren,
    int? countryId,
    int? cityId,
    int? hotelId,
  }) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;
      final url =
          Uri.parse('https://travelta.online/agent/agent/avalibleRooms');

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "country_id": countryId,
            "city_id": cityId,
            "hotel_id": hotelId,
            "check_in": checkIn,
            "check_out": checkOut,
            "max_adults": maxAdults,
            "max_children": maxChildren
          }));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ResultsList results = ResultsList.fromJson(responseData);
        _results = results.results.map((e) => ResultModel.fromJson(e)).toList();
        isLoaded = true;
        notifyListeners();
      } else {
        log('Failed to post booking. Status Code: ${response.statusCode}');
        log('failed to post booking. Response: ${response.body}');
      }
    } catch (e) {
      log('Error in posting booking: $e');
    }
  }
}
