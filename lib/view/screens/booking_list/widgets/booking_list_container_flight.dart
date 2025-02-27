import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/flight_booking_list.dart';
import 'package:flutter_travelta/view/screens/booking_list/screens/booking_list_details_screen.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_view.dart';

class BookingListContainerFlight extends StatelessWidget {
  const BookingListContainerFlight(
      {super.key, required this.flight, required this.selectedTab});
  final Flight flight;
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
            _buildRow('Code', value: flight.code),
            const SizedBox(height: 10),
            _buildRow('Name', value: flight.toName),
            const SizedBox(height: 10),
            _buildRow('Phone', value: flight.toPhone),
            const SizedBox(height: 10),
            _buildRow('Email', value: flight.toEmail),
            const SizedBox(height: 10),
            _buildRow('Role', value: flight.toRole),
            const SizedBox(height: 10),
            _buildRow('Flight Type', value: flight.flightType),
            const SizedBox(height: 10),
            _buildRow('Direction', value: flight.flightDirection),
            const SizedBox(height: 10),
            _buildRow('Status', value: flight.status),
            const SizedBox(height: 10),
            _buildRow('Total Price', value: flight.totalPrice.toString()),
            const SizedBox(height: 10),
            _buildActionsRow(
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) => BookingListDetailsScreen(
                            id: flight.id,
                            type: 'flight',
                            flight: flight,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildActionsRow(void Function() onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton('View Details', onPressed),
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
