import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:flutter_travelta/view/widgets/images_dilaog.dart';
import 'package:provider/provider.dart';
import 'room_details_screen.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({super.key, required this.availableRooms, required this.result});
  final List<AvailableRooms> availableRooms;
  final ResultModel result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Rooms in ${result.hotelName}'), backgroundColor: Colors.white,),
      body: Column(
        children: [
          Stack(
                children: [
                  Image.network(
                    result.hotelLogo,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
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
                            result.images.length > 3 ? 4 : result.images.length,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        result.images[index],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      if (index == 3 && result.images.length > 4)
                                        GestureDetector(
                                          onTap: () {
                                            showImageDialog(context, result.images);
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
                                                "+${result.images.length - 3}",
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
            child: ListView.builder(
              itemCount: availableRooms.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final room = availableRooms[index];
                return RoomCard(room: room,index: index,);
              },
            ),
          ),
        ],
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
                hotelName: result.hotelName,
                roomImage: room.room.gallery[0].thumbUrl,
                images: room.room.gallery.map((e) => e.thumbUrl,).toList(),
                hotelFacilities: result.hotelFacilities,
                hotelFeatures: result.hotelFeatures,
                room: result.availableRooms[index],
                policies: result.hotelPolicies,
                paymentMethods: result.hotelAcceptedCards,
                hotelDescription: result.hotelDescription,
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
