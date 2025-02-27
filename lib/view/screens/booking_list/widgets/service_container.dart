import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelta/constants/colors.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({super.key, required this.type, required this.name, this.roomType, this.numOfRooms});
  final String type;
  final String name;
  final String? roomType;
  final int? numOfRooms;

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                      Text('Hotel Name: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(name,style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Room Type: ',style: TextStyle(color: mainColor,fontSize: 16),),
                    Text(roomType ?? '',style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Number of Rooms: ',style: TextStyle(color: mainColor,fontSize: 16),),
                      Text(numOfRooms.toString(),style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  ),
                ],
              ),
            );
  }
}