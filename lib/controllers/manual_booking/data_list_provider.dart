import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/manual_booking/data_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/manual_booking/manual_booking_model.dart';

class DataListProvider extends ChangeNotifier {
  TravelData? _travelData;
  bool _isLoading = false;
  String? _errorMessage;
  ManualBookingData manualBookingData = ManualBookingData();
  final bool _isSuccess = false;

  TravelData? get travelData => _travelData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

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
      _errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
