import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class BookingResultContainer extends StatelessWidget {
  const BookingResultContainer({super.key, required this.thumbnail, required this.hotelName, required this.price, required this.rating, required this.onPressed});
  final String thumbnail;
  final String hotelName;
  final double price;
  final int rating;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        NetworkImage(thumbnail),
                  ),
                  title: Text(
                    hotelName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Rating: $rating',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(Icons.attach_money, size: 20, color: mainColor),
                        const SizedBox(width: 8),
                        Text(
                          '$price\$ / Night',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.payment, size: 20, color: mainColor),
                          const SizedBox(width: 8),
                          const Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                    ),
                    onPressed: onPressed,
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}