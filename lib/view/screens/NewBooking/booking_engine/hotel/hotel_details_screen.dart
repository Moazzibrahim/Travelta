import 'package:flutter/material.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({super.key, required this.availableRooms});
  final List<AvailableRooms> availableRooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Available Rooms'),
      body: ListView.builder(
        itemCount: availableRooms.length,
        itemBuilder: (context, index) {
          final room = availableRooms[index];
          return ListTile(
            title: Text(room.roomType),
            subtitle: Text('Price: '),
          );
        },
      ),
    );
  }
}