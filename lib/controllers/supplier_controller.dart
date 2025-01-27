// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_travelta/model/supplier.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:provider/provider.dart';

class SupplierController with ChangeNotifier{
  List<Supplier> _suppliers = [];
  List<Supplier> get suppliers => _suppliers;

  List<Service> _services = [];
  List<Service> get services => _services;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> fetchSuppliers(BuildContext context) async {
    try {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    final response = await http.get(Uri.parse('https://travelta.online/agent/supplier'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'accept': 'application/json',
    }
    );
    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      Suppliers suppliers = Suppliers.fromJson(responseData);
      _suppliers = suppliers.suppliers.map((e) => Supplier.fromJson(e),).toList();
      Services services = Services.fromJson(responseData);
      _services = services.services.map((e) => Service.fromJson(e),).toList();
      _isLoaded = true;
      notifyListeners();
    }else{
      log('Failed to fetch suppliers. Status Code: ${response.statusCode}');
    }
    } catch (e) {
      log('error fetching suppliers: $e');
    }
  }

  Future<void> addSupplier(BuildContext context,{
    required String agent,
    required String adminName,
    required String adminEmail,
    required String adminPhone,
    required List<String> emails,
    required List<String> phones,
    required List<int> selectedIds,
  }) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    final response = await http.post(Uri.parse('https://travelta.online/agent/supplier'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'accept': 'application/json',
    },
    body: jsonEncode({
        'agent':agent,
        'admin_name': adminName,
        'admin_email': adminEmail,
        'admin_phone': adminPhone,
        'emails': emails,
        'phones': phones,
        'services': selectedIds,
    }),
    );
    if(response.statusCode == 200){
      showCustomSnackBar(context, 'Supplier added successfully');
    }else{
      log('Failed to add supplier. Status Code: ${response.statusCode}');
    }
  }
}