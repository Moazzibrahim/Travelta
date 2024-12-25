// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class AgencyAddressScreen extends StatefulWidget {
  const AgencyAddressScreen({super.key});

  @override
  _AgencyAddressScreenState createState() => _AgencyAddressScreenState();
}

class _AgencyAddressScreenState extends State<AgencyAddressScreen> {
  String _preferredConnection = 'API/Wholesale'; // Default selection
  String? _selectedCountry;
  String? _selectedState;
  String? _howDidYouHear;
  bool _isTermsAccepted = false; // To track terms acceptance
  final int _currentStep = 3; // Current step indicator
  final List<String> _countries = [
    'Country 1',
    'Country 2',
    'Country 3'
  ]; // Example data
  final List<String> _states = ['State 1', 'State 2', 'State 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agency Address',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // Stepper indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepCircle(1, isActive: _currentStep >= 1),
                _buildStepLine(isActive: _currentStep > 1),
                _buildStepCircle(2, isActive: _currentStep >= 2),
                _buildStepLine(isActive: _currentStep > 2),
                _buildStepCircle(3, isActive: _currentStep == 3),
              ],
            ),
            const SizedBox(height: 20),

            // Address Line 1
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address Line One',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Address Line 2
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address Line Two',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Country Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: _selectedCountry,
              items: _countries
                  .map((country) => DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // State Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select State (N/R)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: _selectedState,
              items: _states
                  .map((state) => DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // City Field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Type A City Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Zip/Postal Code
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Zip/Postal Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Preferred Connection (Radio Buttons)
            const Text(
              'How Would You Prefer To Connect With Travelta?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 10,
              children: [
                _buildRadioButton('Retail'),
                _buildRadioButton('API/Wholesale'),
                _buildRadioButton('Both'),
              ],
            ),
            const SizedBox(height: 20),

            // How Did You Hear About Us Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'How Did You Hear About Us?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: _howDidYouHear,
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _howDidYouHear = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Terms and Conditions
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _isTermsAccepted = value!;
                    });
                  },
                ),
                Text.rich(
                  TextSpan(
                    text: 'I Agree To The ',
                    children: [
                      TextSpan(
                        text: 'Terms And Conditions.',
                        style: TextStyle(
                          color: mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCircle(int step, {bool isActive = false}) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: isActive ? mainColor : Colors.grey,
      child: Text(
        '$step',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStepLine({bool isActive = false}) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? mainColor : Colors.grey,
      ),
    );
  }

  Widget _buildRadioButton(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _preferredConnection,
          onChanged: (newValue) {
            setState(() {
              _preferredConnection = newValue!;
            });
          },
        ),
        Text(value),
      ],
    );
  }
}
