import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/hotel_booking_list.dart';
import 'package:flutter_travelta/view/screens/booking_list/screens/booking_list_details_screen.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_view.dart';

class BookingListContainerHotel extends StatelessWidget {
  const BookingListContainerHotel(
      {super.key, required this.hotel, required this.selectedTab});

  final HotelBookingList hotel;
  final BookingListTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Code', value: hotel.code),
            const SizedBox(height: 10),
            _buildRow('To Name', value: hotel.toName),
            const SizedBox(height: 10),
            _buildRow('To Phone', value: hotel.toPhone),
            const SizedBox(height: 10),
            _buildRow('To Email', value: hotel.toEmail),
            const SizedBox(height: 10),
            _buildRow('To Role', value: hotel.toRole),
            const SizedBox(height: 10),
            _buildRow('Price', value: hotel.totalPrice),
            const SizedBox(height: 10),
            _buildRow('Country', value: hotel.country ?? 'N/A'),
            const SizedBox(height: 10),
            _buildRow('Room Type', value: hotel.roomType.map((x) => x).join(',')),
            const SizedBox(height: 10),
            _buildRow('Adults No.', value: hotel.numOfAdults.toString()),
            const SizedBox(height: 10),
            _buildRow('Children No.', value: hotel.numOfChildren.toString()),
            const SizedBox(height: 10),
            _buildRow('Nights No.', value: hotel.numOfNights.toString()),
            const SizedBox(height: 10),
            _buildActionsRow(() {
              log('View Details pressed');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => BookingListDetailsScreen(
                        id: hotel.id,
                        type: 'Hotel',
                        hotelBookingList: hotel,
                      )));
            }),
          ],
        ),
      ),
    );
  }

  /// Builds a row with text data
  Widget _buildRow(String label, {String? value}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(value ?? 'N/A'),
      ],
    );
  }

  /// Builds action buttons based on the selected tab
  Widget _buildActionsRow(void Function() viewDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton('View Details', viewDetails),
        if (selectedTab != BookingListTab.past) ...[
          const SizedBox(width: 10),
          _buildActionButton('Confirm', () {
            // Handle Confirm action
          }),
          const SizedBox(width: 10),
          _buildActionButton('Delete', () {
            // Handle Delete action
          }, isDestructive: true),
        ],
      ],
    );
  }

  /// Builds an action button
  Widget _buildActionButton(String text, VoidCallback onPressed,
      {bool isDestructive = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDestructive ? Colors.red : mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }
}
