// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/screens/Auth/admin_details_screen.dart';
import 'package:flutter_travelta/view/screens/Auth/agency_address_screen.dart';

class AgencyDetailsScreen extends StatefulWidget {
  const AgencyDetailsScreen({super.key});

  @override
  _AgencyDetailsScreenState createState() => _AgencyDetailsScreenState();
}

class _AgencyDetailsScreenState extends State<AgencyDetailsScreen> {
  final int _currentStep = 2;
  bool _useSameDetails = false;
  bool _agreeToTerms = false;

  void _navigateToStep(BuildContext context, int step) {
    switch (step) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminDetailsScreen(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AgencyDetailsScreen(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AgencyAddressScreen(),
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agency Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper indicators
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepCircle(1, "1"),
                _buildStepLine(),
                _buildStepCircle(2, "2"),
                _buildStepLine(),
                _buildStepCircle(3, "3"),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  // Agency Name Field
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Agency Name',
                      hintStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Phone Field
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.flag, size: 18),
                            SizedBox(width: 5),
                            Text("+20"), // Example country code
                          ],
                        ),
                      ),
                      hintText: 'Phone',
                      hintStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Use Same Details Checkbox
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _useSameDetails,
                    onChanged: (value) {
                      setState(() {
                        _useSameDetails = value!;
                      });
                    },
                    title: const Text(
                      'Use Same Phone Number And Email ID For Agency Details',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 10),
                  // Agree to Terms Checkbox
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                    title: Row(
                      children: [
                        const Text(
                          'I Agree To The ',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Terms and Conditions
                          },
                          child: Text(
                            'Terms And Conditions.',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 30),
                  // Next Button
                  ElevatedButton(
                    onPressed: () {
                      // Add your navigation logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    return GestureDetector(
      onTap: () => _navigateToStep(context, step),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: _currentStep == step ? mainColor : Colors.grey,
        child: Text(
          label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey,
      ),
    );
  }
}
