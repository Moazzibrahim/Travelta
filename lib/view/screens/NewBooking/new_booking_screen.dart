// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelta/view/screens/manual_booking/to_manual_booking_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import '../../../constants/colors.dart';
import 'booking_engine_screen.dart'; // Import the BookingEngineScreen here
import 'manual_booking_screen.dart'; // Import the ManualBookingScreen here

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override   
  // ignore: library_private_types_in_public_api
  _NewBookingScreenState createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  String _selectedOption = 'Booking Engine';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NewBooking'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookingOption(
                    title: 'Booking Engine',
                    svgPath: 'assets/images/Frame 1261154914 (2).svg',
                  ),
                  _buildBookingOption(
                    title: 'Manual Booking',
                    svgPath: 'assets/images/Frame 1261154914 (3).svg',
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedOption == 'Booking Engine') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingEngineScreen(),
                        ),
                      );
                    } else if (_selectedOption == 'Manual Booking') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ToManualBookingScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a valid option.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingOption({
    required String title,
    required String svgPath,
  }) {
    final bool isSelected = _selectedOption == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = title; 
        });
      },
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : secondColor,
          border: Border.all(
            color: isSelected ? mainColor : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: mainColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                color: mainColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgPicture.asset(
              svgPath,
              color: mainColor,
              width: 80.0,
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
