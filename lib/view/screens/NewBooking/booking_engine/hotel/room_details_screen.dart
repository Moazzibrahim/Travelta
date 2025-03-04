import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:flutter_travelta/view/widgets/images_dilaog.dart';
import 'package:flutter_travelta/view/widgets/policies_content.dart';
import 'package:flutter_travelta/view/widgets/rooms_and_facilities_content.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen(
      {super.key,
      required this.hotelImage,
      required this.images,
      required this.hotelFeatures,
      required this.hotelFacilities,
      required this.room,
      required this.policies,
      required this.paymentMethods});
  final String hotelImage;
  final List<String> images;
  final List<HotelFeatures> hotelFeatures;
  final List<HotelFacilities> hotelFacilities;
  final AvailableRooms room;
  final List<HotelPolicies> policies;
  final List<HotelAcceptedCards> paymentMethods;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    hotelImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 280,
                  ),
                  // Back button
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
                        child: Center(
                          child: Icon(Icons.arrow_back_ios,
                              color: mainColor, size: 20),
                        ),
                      ),
                    ),
                  ),
                  // Thumbnails at the bottom center
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            images.length > 3 ? 4 : images.length,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        images[index],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      if (index == 3 && images.length > 4)
                                        GestureDetector(
                                          onTap: () {
                                            showImageDialog(context, images);
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "+${images.length - 3}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
                                'Nila hotel Plaza',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 5),
                                  Text('4.5'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'A luxurious hotel with direct Nile views, offering upscale accommodation, distinguished services, and modern facilities.',
                                  style: TextStyle(fontSize: 11),
                                  softWrap: true,
                                ),
                              ),
                              SvgPicture.asset('assets/images/location.svg')
                            ],
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      indicatorColor: mainColor,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: "Rooms & Facilities"),
                        Tab(text: "Policies & Payments"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          RoomsAndFacilitiesContent(
                            hotelFacilities: hotelFacilities,
                            hotelFeatures: hotelFeatures,
                            room: room,
                          ),
                          PoliciesContent(
                            policies: policies,
                            paymentMethods: paymentMethods,
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
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Reserve'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
