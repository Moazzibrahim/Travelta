import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/costumer_controller.dart';
import 'package:flutter_travelta/model/customer.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    Provider.of<CustomerController>(context, listen: false)
        .fetchCustomer(context);
    super.initState();
  }

  String formatDate(String dateTime) {
    try {
      final DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Clients'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              cursorColor: mainColor,
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or phone number',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            // Customer List
            Expanded(
              child: Consumer<CustomerController>(
                builder: (context, customerProvider, _) {
                  if (!customerProvider.isLoaded) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    );
                  } else {
                    // Filter the customer list based on the search query
                    final filteredCustomers = customerProvider.customers
                        .where((customer) =>
                            customer.name.toLowerCase().contains(searchQuery) ||
                            customer.phone.toLowerCase().contains(searchQuery))
                        .toList();

                    if (filteredCustomers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No clients match your search.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer = filteredCustomers[index];
                        return buildLeadCard(customer);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeadCard(Customer customer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildRow('Name:', customer.name),
          buildRow('Email:', customer.email),
          buildRow('Phone Number:', customer.phone),
          buildRow('Role:', 'Customer'),
          buildRow('Gender:', customer.gender),
          buildRow('Created At:', formatDate(customer.createdAt)),
          buildRowWithBadge(
            'Emergency Phone:',
            customer.emergencyPhone ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRowWithBadge(String label, String value) {
    final isEmergencyAvailable = value != 'N/A';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isEmergencyAvailable ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: isEmergencyAvailable ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
