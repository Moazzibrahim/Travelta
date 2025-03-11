import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/details_tour_widget.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/last_book_tour_screen.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/pricing_tour_widget.dart';
import 'package:provider/provider.dart';

class TourDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> tour;
  final int adultsCount;

  const TourDetailsScreen(
      {super.key, required this.tour, required this.adultsCount});

  @override
  TourDetailsScreenState createState() => TourDetailsScreenState();
}

class TourDetailsScreenState extends State<TourDetailsScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startAutoScroll();
    log(widget.adultsCount.toString());
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < widget.tour['tour_images'].length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> tourImages = widget.tour['tour_images'];
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tourImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          tourImages[index]['image_link'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios,
                              color: Colors.black, size: 20),
                        ),
                      ),
                    ),
                  ),
                  // Dots Indicator
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        tourImages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 12 : 8,
                          height: _currentIndex == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.tour['name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.tour['destinations'][0]['city']
                                      ['name'],
                                  style: const TextStyle(fontSize: 15),
                                  softWrap: true,
                                ),
                              ),
                              SvgPicture.asset('assets/images/location.svg')
                            ],
                          ),
                        ],
                      ),
                    ),
                    const TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Details"),
                        Tab(text: "pricing"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          TourDetailsWidget(tour: widget.tour),
                          TourPricingScreen(
                            tour: widget.tour,
                            adultsCount: widget.adultsCount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Consumer<BookingEngineController>(
                  builder: (context, bookingController, child) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LastBookTourScreen(
                                tour: widget.tour,
                                adultsCount: widget.adultsCount),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Book Now'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
