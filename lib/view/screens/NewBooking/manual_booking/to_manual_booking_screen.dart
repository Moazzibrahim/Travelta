import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/model/manual_booking/manual_booking_model.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';

class ToManualBookingScreen extends StatefulWidget {
  const ToManualBookingScreen({super.key});

  @override
  State<ToManualBookingScreen> createState() => _ToManualBookingScreenState();
}

class _ToManualBookingScreenState extends State<ToManualBookingScreen> {
  String? selectedCategory;
  String? selectedSupplierOrCustomer;
  ManualBookingData manualBookingData = ManualBookingData();

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);

    return Scaffold(
      body: dataListProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownField(
                    label: 'Select category:',
                    items: const [
                      DropdownMenuItem(value: 'b2b', child: Text('B2B')),
                      DropdownMenuItem(value: 'b2c', child: Text('B2C')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        selectedSupplierOrCustomer = null;

                        manualBookingData.selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  IgnorePointer(
                    ignoring: selectedCategory == null,
                    child: Opacity(
                      opacity: selectedCategory == null ? 0.5 : 1.0,
                      child: CustomDropdownField(
                        label: selectedCategory == 'b2b'
                            ? 'Select supplier:'
                            : 'Select customer:',
                        items: selectedCategory == 'b2b'
                            ? dataListProvider.travelData!.suppliers
                                .map((supplier) {
                                return DropdownMenuItem(
                                  value: supplier.id.toString(),
                                  child: Text(supplier.agent!),
                                );
                              }).toList()
                            : dataListProvider.travelData?.customers
                                    .map((customer) {
                                  return DropdownMenuItem(
                                    value: customer.id.toString(),
                                    child: Text(customer.name),
                                  );
                                }).toList() ??
                                [],
                        onChanged: (value) {
                          setState(() {
                            selectedSupplierOrCustomer = value;

                            manualBookingData.selectedSupplierOrCustomer =
                                value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
