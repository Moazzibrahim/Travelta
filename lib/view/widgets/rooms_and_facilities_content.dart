import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/result_model.dart';

class RoomsAndFacilitiesContent extends StatefulWidget {
  const RoomsAndFacilitiesContent({
    super.key,
    required this.hotelFeatures,
    required this.hotelFacilities, required this.room,
  });

  final List<HotelFeatures> hotelFeatures;
  final List<HotelFacilities> hotelFacilities;
  final AvailableRooms room;

  @override
  State<RoomsAndFacilitiesContent> createState() => _RoomsAndFacilitiesContentState();
}

class _RoomsAndFacilitiesContentState extends State<RoomsAndFacilitiesContent> {
  List<Map<String, dynamic>> featuresAndFacilities = [];
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    featuresAndFacilities = [
      ...widget.hotelFeatures.map((feature) => {
            "icon": Icons.local_parking, 
            "title": feature.name,
          }),
      ...widget.hotelFacilities.map((facility) => {
            "icon": Icons.pool, 
            "title": facility.name,
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Features',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: featuresAndFacilities.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item["icon"], size: 20, color: mainColor),
                  const SizedBox(width: 5),
                  Text(
                    item["title"],
                    style: TextStyle(fontSize: 14, color: mainColor),
                  ),
                ],
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Room Facilities',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
  padding: const EdgeInsets.all(8),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.blue.shade50,
  ),
  child: SizedBox(
    height: 180, // Ensure the container does not expand beyond this height
    child: Scrollbar(
      thumbVisibility: true, // Shows the scrollbar indicator
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room Type: ${widget.room.roomType}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: mainColor,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Text('Price: ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: mainColor,
                    fontSize: 16,
                  ),
                ),
                Text(widget.room.room.price.toString())
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: featuresAndFacilities.map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item["icon"], size: 20, color: mainColor),
                    const SizedBox(width: 5),
                    Text(
                      item["title"],
                      style: TextStyle(fontSize: 14, color: mainColor),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${widget.room.room.description}',
              maxLines: isExpanded ? null : 1,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            if (widget.room.room.description.length > 50)
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "View Less" : "View More",
                  style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    ),
  ),
),
        ],
      ),
    );
  }
}
