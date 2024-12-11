import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';

class ResultBookingScreen extends StatelessWidget {
  const ResultBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Result Booking'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
            HotelCard(
            imageUrl: 'https://via.placeholder.com/60',
            hotelName: 'Grand Beach Hotel',
            price: '\$150 / Night',
            paymentMethod: 'Cash',
            rating: '4.5',
          ),
          SizedBox(height: 16),
          HotelCard(
            imageUrl: 'https://via.placeholder.com/60',
            hotelName: 'Ocean View Resort',
            price: '\$200 / Night',
            paymentMethod: 'Credit Card',
            rating: '4.8',
          ),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final String imageUrl;
  final String hotelName;
  final String price;
  final String paymentMethod;
  final String rating;

  const HotelCard({
    super.key,
    required this.imageUrl,
    required this.hotelName,
    required this.price,
    required this.paymentMethod,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotelName,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rating: $rating',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.favorite_border, color: Colors.red),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.payment, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      paymentMethod,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                // Add action, e.g., navigate to booking details
              },
              child: const Text(
                'View Details',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
