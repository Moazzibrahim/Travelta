import 'dart:convert';
import 'dart:developer';
import 'package:flutter_travelta/model/customer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:provider/provider.dart';

class CustomerController with ChangeNotifier {
  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> fetchCustomer(BuildContext context) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final token = loginProvider.token;

      final url = Uri.parse('https://travelta.online/agent/customer');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      );
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        Customers customers = Customers.fromJson(responseData);
        _customers = customers.customers.map((e) => Customer.fromJson(e)).toList();
        _isLoaded = true;
        notifyListeners();
      } else {
        log(response.statusCode.toString());
        log('Failed to load leads. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching customer: $e');
    }
  }
}