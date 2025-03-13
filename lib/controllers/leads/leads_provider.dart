import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/model/leads/lead_model.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LeadsProvider extends ChangeNotifier {
  List<LeadModel> _leads = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<LeadModel> get leads => _leads;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchLeads(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    final url = Uri.parse('https://travelta.online/agent/leads');

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        final jsonData = json.decode(response.body);
        final leadsResponse = LeadsResponse.fromJson(jsonData);
        _leads = leadsResponse.leads;
      } else {
        log(response.statusCode.toString());

        _errorMessage =
            'Failed to load leads. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch leads: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addLead(BuildContext context,{
    required String name,
    required String email,
    required String phone,
    required String wpNum,
    required String gender,
    required int salesAgentId,
    required int nationalityId,
    required int serviceId,
    required int cityId,
    required int countryId,
    required int sourceId,
  }) async{
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;
      final url = Uri.parse('https://travelta.online/agent/leads/add');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "watts": wpNum,
          "gender": gender.toLowerCase(),
          "agent_sales_id": salesAgentId,
          "nationality_id": nationalityId,
          "service_id": serviceId,
          "city_id": cityId,
          "country_id": countryId,
          "source_id": sourceId,
          "status": "active"
        }),
      );
      if(response.statusCode == 200){
        showCustomSnackBar(context, 'Lead Added Successfully');
      }else{
        showCustomSnackBar(context, 'Lead Add failed');
      }
    } catch (e) {
      log('Error adding lead: $e');
    }
  }
}
