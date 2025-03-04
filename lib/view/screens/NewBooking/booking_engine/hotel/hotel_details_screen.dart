import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:provider/provider.dart';
import 'room_details_screen.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({super.key, required this.availableRooms});
  final List<AvailableRooms> availableRooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Rooms')),
      body: ListView.builder(
        itemCount: availableRooms.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final room = availableRooms[index];
          return RoomCard(room: room,index: index,);
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final AvailableRooms room;
  final int index;
  const RoomCard({super.key, required this.room, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          final hotelBookingEngineProvider =
              Provider.of<BookingEngineController>(context, listen: false);
          final result = hotelBookingEngineProvider.results
              .firstWhere((element) => element.availableRooms.contains(room));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsScreen(
                hotelImage: result.hotelLogo,
                images: result.images,
                hotelFacilities: result.hotelFacilities,
                hotelFeatures: result.hotelFeatures,
                room: result.availableRooms[index],
                policies: result.hotelPolicies,
                paymentMethods: result.hotelAcceptedCards,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: room.room.gallery.isNotEmpty
                  ? Image.network(
                      room.room.gallery[0].thumbUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.hotel, size: 50)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.roomType,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Price: \$${room.room.pricings[0].price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 6,
                    children: room.room.roomFeatures
                        .map((feature) => Chip(label: Text(feature.name)))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
