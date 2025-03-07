import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/screens/Auth/agency_address_screen.dart';
import 'package:flutter_travelta/view/screens/Auth/agency_details_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';

class AdminDetailsManualBookingScreen extends StatefulWidget {
  const AdminDetailsManualBookingScreen({super.key});

  @override
  State<AdminDetailsManualBookingScreen> createState() =>
      _AdminDetailsManualBookingScreenState();
}

class _AdminDetailsManualBookingScreenState
    extends State<AdminDetailsManualBookingScreen> {
  final int _currentStep = 1;

  void _navigateToStep(BuildContext context, int step) {
    switch (step) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminDetailsManualBookingScreen(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AgencyDetailsManualBookingScreen(),
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
      appBar: const CustomAppBar(title: "Admin Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper indicator
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
            // Form Fields
            Expanded(
              child: ListView(
                children: [
                  // Title dropdown and first name field
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          value: "Mr",
                          items: const [
                            DropdownMenuItem(
                                value: "Mr",
                                child: Text(
                                  "Mr",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )),
                            DropdownMenuItem(
                                value: "Ms",
                                child: Text(
                                  "Ms",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Last name field
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Phone field
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
                  // Email field
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
                  const SizedBox(height: 30),
                  // Next Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle navigation to the next page
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
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
