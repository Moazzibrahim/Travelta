import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/model/manual_booking/data_list_model.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/markup_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class FromManualBookingScreen extends StatefulWidget {
  final Function(String) onServiceSelected;

  const FromManualBookingScreen({super.key, required this.onServiceSelected});

  @override
  State<FromManualBookingScreen> createState() =>
      _FromManualBookingScreenState();
}

class _FromManualBookingScreenState extends State<FromManualBookingScreen> {
  List<Supplier> filteredSuppliers = [];
  List<Tax> filteredTaxes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataListProvider>(context, listen: false)
          .fetchTravelData(context);
    });
  }

  void _updateSuppliers(String serviceId, List<Service> services) {
    final selectedService =
        services.firstWhere((service) => service.id.toString() == serviceId);
    setState(() {
      filteredSuppliers = selectedService.suppliers;
    });
  }

  void _updateTaxes(String countryId, List<Tax> taxes) {
    final countryTaxes =
        taxes.where((tax) => tax.countryId.toString() == countryId).toList();
    setState(() {
      filteredTaxes = countryTaxes;
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

        return SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Supplier Information'),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: bookingData.selectedServiceId != null
                    ? bookingData.selectedService ?? 'Select Service:'
                    : 'Select Service:',
                items: travelData.services.isEmpty
                    ? []
                    : travelData.services.map((service) {
                        return DropdownMenuItem(
                          value: service.id.toString(),
                          child: Text(service.serviceName),
                        );
                      }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      for (var e in travelData.services) {
                        if (e.id.toString() == value) {
                          bookingData.selectedService = e.serviceName;
                        }
                      }
                      bookingData.selectedServiceId = value;
                    });
                    widget.onServiceSelected(value);
                    _updateSuppliers(value, travelData.services);
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: bookingData.fromselectedSupplierId != null
                    ? bookingData.selectedSupplier ?? 'Supplier not selected'
                    : 'Select supplier:',
                items: filteredSuppliers.isEmpty
                    ? []
                    : filteredSuppliers.map((supplier) {
                        return DropdownMenuItem(
                          value: supplier.id.toString(),
                          child: Text(supplier.agent),
                        );
                      }).toList(),
                onChanged: (value) {
                  setState(() {
                    for (var e in travelData.suppliers) {
                      if (e.id.toString() == value) {
                        bookingData.selectedSupplier = e.agent;
                      }
                    }
                    bookingData.fromselectedSupplierId = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: 'Cost And Currency'),
              CustomDropdownField(
                label: bookingData.selectedCurrencyId != null
                    ? bookingData.selectedCurrency!
                    : 'Select currency:',
                items: travelData.currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency.id.toString(),
                    child: Text(currency.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    for (var e in travelData.currencies) {
                      if (e.id.toString() == value) {
                        bookingData.selectedCurrency = e.name;
                      }
                    }
                    bookingData.selectedCurrencyId = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Cost:',
                isNumeric: true,
                initialValue: bookingData.cost.toString(),
                onChanged: (value) {
                  setState(() {
                    bookingData.setCost(double.tryParse(value) ?? 0.0);
                  });
                },
              ),
              const SizedBox(height: 32),
              const SectionTitle(title: 'Mark Up'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MarkupButton(
                        text: '\$',
                        selectedMarkup: bookingData.selectedMarkup,
                        onPressed: () {
                          setState(() {
                            bookingData.selectedMarkup = 'value';
                            bookingData.calculateFinalPrice();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      MarkupButton(
                        text: '%',
                        selectedMarkup: bookingData.selectedMarkup,
                        onPressed: () {
                          setState(() {
                            bookingData.selectedMarkup = 'precentage';
                            bookingData.calculateFinalPrice();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  if (bookingData.selectedMarkup.isNotEmpty)
                    Expanded(
                      child: CustomTextField(
                        label: 'Markup Value:',
                        isNumeric: true,
                        initialValue: bookingData.markupValue.toString(),
                        onChanged: (value) {
                          setState(() {
                            bookingData
                                .setMarkupValue(double.tryParse(value) ?? 0.0);
                            bookingData.calculateFinalPrice();
                          });
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: 'Tax Details'),
              CustomDropdownField(
                label: bookingData.selectedCountryId != null
                    ? bookingData.selectedCountry ?? 'Select country'
                    : 'Select country:',
                items: travelData.countries.isEmpty
                    ? []
                    : travelData.countries.map((country) {
                        return DropdownMenuItem(
                          value: country.id.toString(),
                          child: Text(country.name),
                        );
                      }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      bookingData.selectedCountryId = value;
                      bookingData.selectedCityId =
                          null; // Reset city when country changes
                      bookingData.selectedCity = null;

                      for (var e in travelData.countries) {
                        if (e.id.toString() == value) {
                          bookingData.selectedCountry = e.name;
                        }
                      }
                    });
                    _updateTaxes(value, travelData.taxes);
                  }
                },
              ),
              const SizedBox(height: 15),
              CustomDropdownField(
                label: bookingData.selectedCityId != null
                    ? bookingData.selectedCity ?? 'Select city'
                    : 'Select city:',
                items: travelData.cities
                    .where((city) =>
                        city.countryId.toString() ==
                        bookingData.selectedCountryId)
                    .map((city) {
                  return DropdownMenuItem(
                    value: city.id.toString(),
                    child: Text(city.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      bookingData.selectedCityId = value;
                      for (var e in travelData.cities) {
                        if (e.id.toString() == value) {
                          bookingData.selectedCity = e.name;
                        }
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: bookingData.selectedTaxId != null
                    ? bookingData.selectedTax ?? 'Select tax'
                    : 'Select tax:',
                items: filteredTaxes.isEmpty
                    ? []
                    : filteredTaxes.map((tax) {
                        return DropdownMenuItem(
                          value: tax.id.toString(),
                          child: Text(tax.name),
                        );
                      }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      bookingData.selectedTaxId = value;
                      for (var e in travelData.taxes) {
                        if (e.id.toString() == value) {
                          bookingData.selectedTax = e.name;
                          bookingData.selectedTaxAmount =
                              e.amount; // Store selected tax amount
                        }
                      }
                      bookingData
                          .calculateFinalPrice(); // Recalculate final price
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: 'Select Tax Type:',
                items: const [
                  DropdownMenuItem(value: 'include', child: Text('Include')),
                  DropdownMenuItem(value: 'exclude', child: Text('Exclude')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      bookingData.selectedTaxType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              const SectionTitle(title: 'Final Price'),
              Text(
                'Final Price: \$${bookingData.finalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
