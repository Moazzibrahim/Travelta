import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/tour/tour_details_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';

class TourListScreen extends StatelessWidget {
  final Map<String, dynamic> tourData;
  final int adultsCount;

  const TourListScreen(
      {super.key, required this.tourData, required this.adultsCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Tours"),
      body: tourData["count"] > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: tourData["tours"].length,
              itemBuilder: (context, index) {
                final tour = tourData["tours"][index];
                return TourCard(
                  tour: tour,
                  adultsCount: adultsCount,
                );
              },
            )
          : const Center(
              child: Text(
                "No Tours Found",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}

class TourCard extends StatelessWidget {
  final Map<String, dynamic> tour;
  final int adultsCount;

  const TourCard({super.key, required this.tour, required this.adultsCount});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = tour["image_link"] ?? "";
    final String tourName = tour["name"] ?? "Unknown Tour";
    final String description =
        tour["description"] ?? "No description available.";
    final String featuredFrom = tour["featured_from"] ?? "N/A";
    final String featuredTo = tour["featured_to"] ?? "N/A";
    final int nights = tour["nights"] ?? 0;
    final String cityName =
        (tour["destinations"] != null && tour["destinations"].isNotEmpty)
            ? tour["destinations"][0]["city"]["name"] ?? "Unknown City"
            : "Unknown City";
    final double price = tour['tour_pricing_items'][0]['price_after_tax'] !=
            null
        ? double.tryParse(
                tour['tour_pricing_items'][0]['price_after_tax'].toString()) ??
            0.0
        : 0.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TourDetailsScreen(
              tour: tour,
              adultsCount: adultsCount,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tourName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                  _buildIconText(Icons.date_range,
                      "$featuredFrom - $featuredTo", Colors.blue),
                  _buildIconText(
                      Icons.nightlight, "$nights Nights", Colors.indigo),
                  _buildIconText(Icons.location_city, cityName, Colors.orange),
                  _buildIconText(
                      Icons.attach_money, "$price EGP", Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
