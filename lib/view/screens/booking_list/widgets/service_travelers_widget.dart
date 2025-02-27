import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/booking_list_details.dart';

class ServiceTravelersWidget extends StatelessWidget {
  const ServiceTravelersWidget({super.key, required this.bookingListDetails});
  final BookingListDetails bookingListDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Travelers',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: mainColor),
        ),
        const SizedBox(height: 16),
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.2,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Travelers Details',
                    style: TextStyle(fontSize: 20, color: mainColor),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Traveler Name:', style: TextStyle(color: mainColor, fontSize: 16),),
                        Text(bookingListDetails.traveler.name, style: TextStyle(color: mainColor, fontSize: 16),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Traveler Email:', style: TextStyle(color: mainColor, fontSize: 16),),
                        Text(bookingListDetails.traveler.email, style: TextStyle(color: mainColor, fontSize: 16),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Traveler Phone:', style: TextStyle(color: mainColor, fontSize: 16),),
                        Text(bookingListDetails.traveler.phone, style: TextStyle(color: mainColor, fontSize: 16),),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
