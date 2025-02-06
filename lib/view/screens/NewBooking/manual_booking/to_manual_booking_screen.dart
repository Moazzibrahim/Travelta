import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';

class ToManualBookingScreen extends StatefulWidget {
  const ToManualBookingScreen({super.key});

  @override
  State<ToManualBookingScreen> createState() => _ToManualBookingScreenState();
}

class _ToManualBookingScreenState extends State<ToManualBookingScreen> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataListProvider>(context, listen: false)
          .fetchTravelData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingData =
        Provider.of<DataListProvider>(context).manualBookingData;

    return Consumer<DataListProvider>(
      builder: (context, dataListProvider, child) {
        if (dataListProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (dataListProvider.errorMessage != null) {
          return Center(child: Text(dataListProvider.errorMessage!));
        }

        final travelData = dataListProvider.travelData;

        if (travelData == null) {
          return const Center(child: Text("Failed to load travel data"));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropdownField(
                label: bookingData.selectedCategory != null
                    ? bookingData.selectedCategory ?? 'category not selected'
                    : 'Select category:',
                value: selectedCategory,
                items: const [
                  DropdownMenuItem(value: 'b2b', child: Text('B2B')),
                  DropdownMenuItem(value: 'b2c', child: Text('B2C')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    // Reset the supplier or customer field when category changes
                    bookingData.selectedtoSupplier = null;
                    bookingData.selectedtoSupplierId = null;
                    bookingData.selectedtoCustomer = null;
                    bookingData.selectedtoCustomerId = null;
                    dataListProvider.manualBookingData.selectedCategory = value;
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
                        ? (bookingData.selectedtoSupplier != null
                            ? bookingData.selectedtoSupplier ??
                                'selectedtoSupplier not selected'
                            : 'Select supplier:')
                        : (bookingData.selectedtoCustomer != null
                            ? bookingData.selectedtoCustomer ??
                                'selectedtoCustomer not selected'
                            : 'Select customer:'),
                    value: selectedCategory == 'b2b'
                        ? bookingData.selectedtoSupplier
                        : bookingData.selectedtoCustomer,
                    items: selectedCategory == 'b2b'
                        ? dataListProvider.travelData!.suppliers
                            .map((supplier) {
                            return DropdownMenuItem(
                              value: supplier.id
                                  .toString(), // Ensure this is unique
                              child: Text(supplier.agent),
                            );
                          }).toList()
                        : dataListProvider.travelData?.customers
                                .map((customer) {
                              return DropdownMenuItem(
                                value: customer.id
                                    .toString(), // Ensure this is unique
                                child: Text(customer.name),
                              );
                            }).toList() ??
                            [],
                    onChanged: (value) {
                      setState(() {
                        if (selectedCategory == 'b2b') {
                          // Update supplier fields
                          bookingData.selectedtoSupplier = value;
                          for (var e in travelData.suppliers) {
                            if (e.id.toString() == value) {
                              bookingData.selectedtoSupplierId =
                                  e.id.toString();
                            }
                          }
                        } else if (selectedCategory == 'b2c') {
                          // Update customer fields
                          bookingData.selectedtoCustomer = value;
                          for (var e in travelData.customers) {
                            if (e.id.toString() == value) {
                              bookingData.selectedtoCustomerId =
                                  e.id.toString();
                            }
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
