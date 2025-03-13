import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/agent_booking.dart';
import 'package:flutter_travelta/model/book_room.dart';
import 'package:flutter_travelta/model/book_tour.dart';
import 'package:flutter_travelta/model/booking_engine_model.dart';
import 'package:flutter_travelta/model/customer_booking.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/hotel/voucher_hotel_booking_engine.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/voucher_tour_booking_engine_screen.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
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

  List<CustomerBooking> _customers = [];
  List<CustomerBooking> get customers => _customers;

  List<AgentBooking> _agents = [];
  List<AgentBooking> get agents => _agents;
  bool isCustomersLoaded = false;

  BookRoom _bookRoom = BookRoom();
  BookRoom get bookRoom => _bookRoom;

  bool get isResultsEmpty => _results.isEmpty;

  bool isLoaded = false;
  bool isAgentsLoaded = false;
  List<TourType> _tourTypes = [];
  List<TourType> get tourTypes => _tourTypes;

  List<Nationaility> _nationalities = [];
  List<Nationaility> get nationalities => _nationalities;

  final TourBooking _tourBooking = TourBooking();
  TourBooking get tourBooking => _tourBooking;

  void updateTotalPrice(double price) {
    _tourBooking.totalPrice = price;
    notifyListeners();
  }

  void updateRoomCount(String roomType, int count) {
    _tourBooking.updateRoomCount(roomType, count);
    notifyListeners();
  }
Future<void> booktour(
  BuildContext context, {
  int? tourId,
  int? noOfPeople,
  int? currencyId,
  double? totalPrice,
  int? customerId,
  String? specialRequest,
  int? agentsId,
  String status = "confirmed",
  int? toHotelId,
  int? singleRoomCount,
  int? doubleRoomCount,
  int? tripleRoomCount,
  int? quadRoomCount,
  List<Map<String, dynamic>>? extras,
}) async {
  try {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    final url = Uri.parse('https://travelta.online/agent/agent/bookTour');

    Map<String, dynamic> requestBody = {
      "tour_id": tourId,
      "no_of_people": noOfPeople,
      "special_request": specialRequest,
      "currency_id": currencyId,
      "total_price": totalPrice,
      "status": status,
      "to_hotel_id": toHotelId,
      "single_room_count": singleRoomCount,
      "double_room_count": doubleRoomCount,
      "triple_room_count": tripleRoomCount,
      "quad_room_count": quadRoomCount,
      "extras": extras ?? [],
    };

    if (customerId != null) requestBody["customer_id"] = customerId;
    if (agentsId != null) requestBody["agents_id"] = agentsId;

    log(requestBody.toString());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      log('Tour booking successful: ${response.body}');
      final responseData = jsonDecode(response.body);

      // Navigate to VoucherTourBookingEngine with response data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VoucherTourBookingEngine(responseData: responseData),
        ),
      );
    } else {
      log('Failed to post tour booking. Status Code: ${response.statusCode}');
      log('Response: ${response.body}');
    }
  } catch (e) {
    log('Error in posting tour booking: $e');
  }
}

  Future<void> fetchTourTypes(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final url = Uri.parse('https://travelta.online/agent/gettourtypes');

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
        TourTypeList tourTypeList = TourTypeList.fromJson(responseData);
        _tourTypes = tourTypeList.tourTypes;
        notifyListeners();
      } else {
        log('Failed to load tour types. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching tour types: $e');
    }
  }

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

  Future<void> fetchCustomers(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    try {
      final url = Uri.parse('https://travelta.online/agent/getCustomers');

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
        CustomerBookingList customers =
            CustomerBookingList.fromJson(responseData);
        _customers = customers.customerBookings
            .map((e) => CustomerBooking.fromJson(e))
            .toList();
        isCustomersLoaded = true;

        notifyListeners();
      }
    } catch (e) {
      log('Error in fetching customers: $e');
    }
  }

  Future<void> fetchAgents(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    try {
      final url = Uri.parse('https://travelta.online/agent/getagents');

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
        AgentBookingList agents = AgentBookingList.fromJson(responseData);
        _agents =
            agents.agentBookings.map((e) => AgentBooking.fromJson(e)).toList();
        isAgentsLoaded = true;

        notifyListeners();
      }
    } catch (e) {
      log('Error in fetching agents: $e');
    }
  }

  Future<void> postBookRoom(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final url =
          Uri.parse('https://travelta.online/agent/agent/bookingEngine');
      // log('${bookRoom.roomId}');
      // log('${bookRoom.checkIn}');
      // log('${bookRoom.checkOut}');
      // log('${bookRoom.quantity}');
      // log('${bookRoom.fromSupplierId}');
      // log('${bookRoom.countryId}');
      // log('${bookRoom.cityId}');
      // log('${bookRoom.hotelId}');
      // log('${bookRoom.toAgentId}');
      // log('${bookRoom.toCustomerId}');
      // log('${bookRoom.roomType}');
      // log('${bookRoom.adults}');
      // log('${bookRoom.children}');
      // log('${bookRoom.noOfNights}');
      // log('1');
      // log(bookRoom.amount.toString());

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "room_id": bookRoom.roomId,
            "check_in": bookRoom.checkIn,
            "check_out": bookRoom.checkOut,
            "quantity": bookRoom.quantity,
            "from_supplier_id": bookRoom.fromSupplierId,
            "country_id": bookRoom.countryId,
            "city_id": bookRoom.cityId,
            "hotel_id": bookRoom.hotelId,
            "to_agent_id": bookRoom.toAgentId,
            "to_customer_id": bookRoom.toCustomerId,
            "room_type": bookRoom.roomType,
            "no_of_adults": bookRoom.adults,
            "no_of_children": bookRoom.children,
            "no_of_nights": bookRoom.noOfNights,
            "currency_id": bookRoom.currencyId ?? 3,
            "amount": bookRoom.amount
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(context, 'The room booked Successfully');
        final responsedata = json.decode(response.body);
        _bookRoom = BookRoom.fromJson(responsedata['booking_list']);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (ctx) => const VoucherHotelBookingEngine()),
        );
        notifyListeners();
      } else {
        log('Failed to post room booking. Status Code: ${response.statusCode}');
        log('Response: ${response.body}');
      }
    } catch (e) {
      log('Error in posting booking: $e');
    }
  }

  Future<Map<String, dynamic>?> postTourBooking(
    BuildContext context, {
    required int year,
    required int month,
    required int people,
    int? destinationCountry,
    int? destinationCity,
    required int tourTypeId,
  }) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;
      final url = Uri.parse('https://travelta.online/agent/agent/tours');

      final Map<String, dynamic> requestBody = {
        "year": year,
        "month": month,
        "people": people,
        "tour_type_id": tourTypeId,
      };

      if (destinationCountry != null) {
        requestBody["destination_country"] = destinationCountry;
      }
      if (destinationCity != null) {
        requestBody["destination_city"] = destinationCity;
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        log('Failed to post tour booking. Status Code: ${response.statusCode}');
        log('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error in posting tour booking: $e');
      return null;
    }
  }

  Future<void> fetchNationalities(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    final url = Uri.parse('https://travelta.online/agent/getNationalties');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      NationailityList nationalities = NationailityList.fromJson(responseData);
      _nationalities = nationalities.nationailities
          .map(
            (e) => Nationaility.fromJson(e),
          )
          .toList();
    } else {
      log('Failed to get nationalities: ${response.statusCode}');
      log('Response: ${response.body}');
    }
  }
}
