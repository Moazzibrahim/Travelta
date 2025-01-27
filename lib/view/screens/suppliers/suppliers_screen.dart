import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/supplier_controller.dart';
import 'package:flutter_travelta/model/supplier.dart';
import 'package:flutter_travelta/view/screens/suppliers/add_supplier.dart';
import 'package:provider/provider.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Provider.of<SupplierController>(context, listen: false).fetchSuppliers(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: mainColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Suppliers',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add, color: mainColor,size: 30,),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx)=> const AddSupplierScreen())
            );
          },
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: mainColor,
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by name or phone',
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
            ),
          ),
          Expanded(
            child: Consumer<SupplierController>(
              builder: (context, supplierProvider, _) {
                if (!supplierProvider.isLoaded) {
                  return Center(
                    child: CircularProgressIndicator(color: mainColor),
                  );
                } else if (supplierProvider.suppliers.isEmpty) {
                  return Center(
                    child: Text(
                      'No suppliers available.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  );
                } else {
                  // Filter suppliers based on the search query
                  final filteredSuppliers = supplierProvider.suppliers.where((supplier) {
                    return supplier.name.toLowerCase().contains(_searchQuery) ||
                        supplier.emergencyPhone!.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (filteredSuppliers.isEmpty) {
                    return Center(
                      child: Text(
                        'No suppliers match your search.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filteredSuppliers.length,
                    itemBuilder: (context, index) {
                      final supplier = filteredSuppliers[index];
                      return buildSupplierCard(supplier);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupplierCard(Supplier supplier) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Name', supplier.name),
            const SizedBox(height: 8),
            buildRow('Role', 'Supplier'),
            const SizedBox(height: 8),
            buildRowWithBadge('Emergency Phone', supplier.emergencyPhone!),
            const SizedBox(height: 16),
            const Text(
              'Services',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: supplier.services.map((service) {
                return Chip(
                  label: Text(service.name),
                  backgroundColor: Colors.blue[50],
                  labelStyle: TextStyle(color: Colors.blue[800]),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
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
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget buildRowWithBadge(String label, String value) {
    final isEmergencyAvailable = value != 'N/A';
    return Row(
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
              color: isEmergencyAvailable ? Colors.green[800] : Colors.red[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
