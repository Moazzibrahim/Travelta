import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelta/constants/colors.dart';

class TourMainWidget extends StatelessWidget {
  const TourMainWidget({super.key, required this.type, required this.tourName, required this.tourType, required this.hotelName, required this.destination, required this.transporation, required this.seats});
  final String type;
  final String tourName;
  final String tourType;
  final String hotelName;
  final String destination;
  final String transporation;
  final String seats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.4,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/hotel_service_icon.svg'),
                      const SizedBox(width: 5,),
                      Text(
                        '$type Service',
                        style: TextStyle(fontSize: 20, color: mainColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tour name: ',style: TextStyle(color: mainColor,fontSize: 16),),
                    Text(tourName,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tour Type: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(tourType,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hotel name: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(hotelName,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Destination: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(destination,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transportation: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(transporation,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Seats: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(seats,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                ],
              ),
    );
  }
}