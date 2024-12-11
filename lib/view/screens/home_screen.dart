import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine_screen.dart';
import 'package:flutter_travelta/view/screens/operation/operation_screen.dart';
import 'package:flutter_travelta/view/screens/request/request_screen.dart';

import 'NewBooking/new_booking_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hello Admin',
          style: TextStyle(color: mainColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: mainColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: mainColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
          children: [
            _buildDashboardCard(
              context: context,
              svgPath: "assets/images/Frame 1261154914.svg",
              label: "Operation",
              targetScreen: const OperationScreen(),
            ),
            _buildDashboardCard(
              context: context,
              svgPath: "assets/images/Frame 1261154914 (1).svg",
              label: "Request",
              targetScreen: const RequestScreen(),
            ),
            _buildDashboardCard(
              context: context,
              svgPath: "assets/images/Frame 1261154914 (2).svg",
              label: "New Booking",
              targetScreen: const NewBookingScreen(),
            ),
            _buildDashboardCard(
              context: context,
              svgPath: "assets/images/Frame 1261154914 (3).svg",
              label: "Booking Payment",
              targetScreen: const BookingEngineScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String svgPath,
    required String label,
    required Widget targetScreen,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    color: mainColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    svgPath,
                    width: 120,
                    height: 120,
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
