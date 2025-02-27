import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelta/constants/colors.dart';

class FlightMainWidget extends StatelessWidget {
  const FlightMainWidget({super.key, required this.type, required this.from, required this.to, required this.flightType});
  final String type;
  final String from;
  final String to;
  final String flightType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.2,
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
                      Text('Flight Type: ',style: TextStyle(color: mainColor,fontSize: 16),),
                    Text(flightType,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('From: ',style: TextStyle(color: mainColor,fontSize: 16),),
                    Text(from,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('To: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(to,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                ],
              ),
    );
  }
}