import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/leads/leads_provider.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/view/screens/lead/widgets/add_lead_textfield.dart';
import 'package:flutter_travelta/view/screens/lead/widgets/custom_add_lead_dropdown.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final wpNumController = TextEditingController();
  final emailController = TextEditingController();

  String? selectedGender;
  String? selectedAgent;
  String? selectedNationality;
  String? selectedService;
  String? selectedCity;
  String? selectedSource;
  String? selectedCountry;
  int? selectedGenderId;
  int? selectedAgentId;
  int? selectedNationalityId;
  int? selectedServiceId;
  int? selectedCityId;
  int? selectedSourceId;
  int? selectedCountryId;

  @override
  void initState() {
    Provider.of<DataListProvider>(context, listen: false)
        .fetchTravelData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Lead'),
      body: Consumer2<LeadsProvider, DataListProvider>(
        builder: (context, leadProvider, dataListProvider, _) {
          if (dataListProvider.travelData == null) {
            return Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            );
          } else {
            final List<String> agents = dataListProvider.travelData!.emploees
                .map((e) => e.name)
                .toList();
            final List<String> nationalities = dataListProvider
                .travelData!.nationalities
                .map((e) => e.name)
                .toList(); // Example data
            final List<String> services = dataListProvider.travelData!.services
                .map((e) => e.serviceName)
                .toList();
            final List<String> cities =
                dataListProvider.travelData!.cities.map((e) => e.name).toList();
            final List<String> sources = dataListProvider.travelData!.sources
                .map((e) => e.name)
                .toList();
            final List<String> countries = dataListProvider.travelData!.emploees
                .map((e) => e.name)
                .toList();

            final List<int> agentsId =
                dataListProvider.travelData!.emploees.map((e) => e.id).toList();
            final List<int> servicesIds =
                dataListProvider.travelData!.services.map((e) => e.id).toList();
            final List<int> nationalitiesIds = dataListProvider
                .travelData!.nationalities
                .map((e) => e.id)
                .toList();
            final List<int> sourcesIds =
                dataListProvider.travelData!.sources.map((e) => e.id).toList();
            final List<int> citiesIds =
                dataListProvider.travelData!.cities.map((e) => e.id).toList();
            final List<int> countriesIds = dataListProvider
                .travelData!.countries
                .map((e) => e.id)
                .toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildTextField("Name", "Enter name", nameController),
                          const SizedBox(height: 16),
                          buildTextField("Email", "Enter email", emailController),
                          const SizedBox(height: 16),
                          buildTextField("Phone", "Enter phone", phoneController),
                          const SizedBox(height: 16),
                          buildTextField("Whatsapp Number","Enter whatsapp number", wpNumController),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomDropdown(
                            label: 'Gender',
                            items: const ['Male', 'Female'],
                            selectedValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Sales Agent Dropdown
                          CustomDropdown(
                            label: 'Sales Agent',
                            items: agents,
                            selectedValue: selectedAgent,
                            onChanged: (value) {
                              setState(() {
                                selectedAgent = value;
                                selectedAgentId =
                                    agentsId[agents.indexOf(value!)];
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Nationality Dropdown
                          CustomDropdown(
                            label: 'Nationality',
                            items: nationalities,
                            selectedValue: selectedNationality,
                            onChanged: (value) {
                              setState(() {
                                selectedNationality = value;
                                selectedNationalityId = nationalitiesIds[
                                    nationalities.indexOf(value!)];
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Services Dropdown
                          CustomDropdown(
                            label: 'Services',
                            items: services,
                            selectedValue: selectedService,
                            onChanged: (value) {
                              setState(() {
                                selectedService = value;
                                selectedServiceId =
                                    servicesIds[services.indexOf(value!)];
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Cities Dropdown
                          CustomDropdown(
                            label: 'City',
                            items: cities,
                            selectedValue: selectedCity,
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value;
                                selectedCityId =
                                    citiesIds[cities.indexOf(value!)];
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Sources Dropdown
                          CustomDropdown(
                            label: 'Source',
                            items: sources,
                            selectedValue: selectedSource,
                            onChanged: (value) {
                              setState(() {
                                selectedSource = value;
                                selectedSourceId =
                                    sourcesIds[sources.indexOf(value!)];
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Countries Dropdown
                          CustomDropdown(
                            label: 'Country',
                            items: countries,
                            selectedValue: selectedCountry,
                            onChanged: (value) {
                              setState(() {
                                selectedCountry = value;
                                selectedCountryId =
                                    countriesIds[countries.indexOf(value!)];
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (selectedAgent != null ||
                            selectedNationality != null ||
                            selectedService != null ||
                            selectedCity != null ||
                            selectedSource != null ||
                            selectedCountry != null) {
                          Provider.of<LeadsProvider>(context, listen: false).addLead(
                            context,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            wpNum: wpNumController.text,
                            gender: selectedGender!,
                            salesAgentId: selectedAgentId!,
                            nationalityId: selectedNationalityId!,
                            serviceId: selectedServiceId!,
                            cityId: selectedCityId!,
                            countryId: selectedCountryId!,
                            sourceId: selectedServiceId!,
                          );
                          setState(() {
                            nameController.clear();
                            emailController.clear();
                            phoneController.clear();
                            wpNumController.clear();
                            selectedGender = null;
                            selectedAgent = null;
                            selectedNationality = null;
                            selectedService = null;
                            selectedCity = null;
                            selectedCountry = null;
                            selectedSource = null;
                            selectedAgentId = null;
                            selectedNationalityId = null;
                            selectedServiceId = null;
                            selectedCityId = null;
                            selectedCountryId = null;
                            selectedSourceId = null;
                          });
                        } else {
                          showCustomSnackBar(context, 'please fill all fields',backgroundColor: Colors.black);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Add'))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
