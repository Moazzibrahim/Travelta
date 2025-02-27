import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/request/request_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TravelProvider extends ChangeNotifier {
  TravelData? travelData;
  bool isLoading = false;
  String errorMessage = '';
  DealModel? dealData;
  Future<void> postStages(
    BuildContext context,
    String id,
    String? stages,
    String? action,
    DateTime? followUpDate,
    String? result,
    String? sendBy,
    int? adminAgentId,
    String? code,
    String? lostReason,
  ) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    final url = Uri.parse('https://travelta.online/agent/request/stages/$id');

    try {
      isLoading = true;
      notifyListeners();

      final Map<String, dynamic> requestBody = {
        'stages': stages,
        'action': action,
        'follow_up_date': followUpDate?.toIso8601String(),
        'result': result,
        'send_by': sendBy,
        'admin_agent_id': adminAgentId,
        'code': code,
        'lost_reason': lostReason,
      }..removeWhere((key, value) => value == null || value.toString().isEmpty);

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      log(response.body);
      log(url.toString());

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        log(response.body);
        errorMessage = '';
      } else {
        log(response.statusCode.toString());
        log(response.body);
        errorMessage = 'Failed to post stages';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> postPriority(
      BuildContext context, String id, String priority) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    final url = Uri.parse('https://travelta.online/agent/request/priority/$id');

    try {
      isLoading = true;
      notifyListeners();

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'priority': priority}),
      );
      log(url.toString());
      log(response.body);

      if (response.statusCode == 200) {
        errorMessage = '';
      } else {
        log(response.statusCode.toString());
        errorMessage = 'Failed to update priority';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDealData(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    final url = Uri.parse('https://travelta.online/agent/request/lists');

    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        final Map<String, dynamic> data = json.decode(response.body);
        dealData = DealModel.fromJson(data);
        errorMessage = '';
      } else {
        errorMessage = 'Failed to load deal data';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTravelData(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    final url = Uri.parse('https://travelta.online/agent/request');

    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        final Map<String, dynamic> data = json.decode(response.body);
        travelData = TravelData.fromJson(data);
        errorMessage = '';
      } else {
        errorMessage = 'Failed to load data';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
