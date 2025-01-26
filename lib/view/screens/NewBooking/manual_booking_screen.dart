import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/details_manual_booking_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/from_manual_booking_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/manual_booking/to_manual_booking_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/widgets/stepper_widget.dart';

class ManualBookingScreen extends StatefulWidget {
  const ManualBookingScreen({super.key});

  @override
  State<ManualBookingScreen> createState() => _ManualBookingScreenState();
}

class _ManualBookingScreenState extends State<ManualBookingScreen> {
  late PageController _pageController;
  late int currentIndex;
  String selectedService = '';

  final List<StepData> steps = [
    StepData(
      label: "From",
      screen: FromManualBookingScreen(
        onServiceSelected: (String) {},
      ),
    ),
    StepData(label: "To", screen: const ToManualBookingScreen()),
    StepData(label: "Details", screen: const SizedBox()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    currentIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  void _onStepTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (currentIndex < steps.length - 1) {
      setState(() { 
        currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Manual Booking"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StepperRow(
              steps: steps,
              currentIndex: currentIndex,
              onStepTapped: _onStepTapped,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: [
                  FromManualBookingScreen(onServiceSelected: _updateService),
                  const ToManualBookingScreen(),
                  DetailsManualBookingScreen(selectedService: selectedService),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentIndex > 0 ? _onPrevious : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentIndex > 0 ? mainColor : Colors.grey,
                  ),
                  child: const Text(
                    "Previous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: currentIndex < steps.length - 1 ? _onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentIndex < steps.length - 1
                        ? mainColor
                        : Colors.grey,
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
