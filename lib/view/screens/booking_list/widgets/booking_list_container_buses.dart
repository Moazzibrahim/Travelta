import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/bus_booking_list.dart';
import 'package:flutter_travelta/view/screens/booking_list/screens/booking_list_details_screen.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_view.dart';

class BookingListContainerBuses extends StatelessWidget {
  const BookingListContainerBuses(
      {super.key, required this.bus, required this.selectedTab});
  final BusBookingList bus;
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
            _buildRow('Code', value: bus.code),
            const SizedBox(height: 10),
            _buildRow('Name', value: bus.toName),
            const SizedBox(height: 10),
            _buildRow('Phone', value: bus.toPhone),
            const SizedBox(height: 10),
            _buildRow('Email', value: bus.toEmail),
            const SizedBox(height: 10),
            _buildRow('Role', value: bus.toRole),
            const SizedBox(height: 10),
            _buildRow('Price', value: bus.totalPrice.toString()),
            const SizedBox(height: 10),
            _buildRow('Country', value: bus.country ?? 'N/A'),
            const SizedBox(height: 10),
            _buildActionsRow(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => BookingListDetailsScreen(
                        bus: bus,
                        type: 'bus',
                        id: bus.id,
                      )));
            }),
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
