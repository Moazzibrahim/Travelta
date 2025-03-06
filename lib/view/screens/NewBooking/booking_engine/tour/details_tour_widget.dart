import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class TourDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> tour;

  const TourDetailsWidget({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Description", Icons.info),
          Text(
            tour['description'] ?? "No description",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          const SizedBox(height: 10),
          _buildInfoRow("Nights:", "${tour['nights']}"),
          _buildInfoRow("Featured From:", tour['featured_from']),
          _buildInfoRow("Featured To:", tour['featured_to']),
          const Divider(),
          _buildSectionCard(
            title: "Itinerary",
            icon: Icons.map,
            children: tour['itinerary']
                .map<Widget>((item) => ListTile(
                      leading: Icon(Icons.calendar_today, color: mainColor),
                      title: Text(
                        item['day_name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(item['day_description']),
                    ))
                .toList(),
          ),
          _buildSectionCard(
            title: "Includes",
            icon: Icons.check_circle,
            children: tour['includes']
                .map<Widget>((item) => _buildBulletPoint(item['name']))
                .toList(),
          ),
          _buildSectionCard(
            title: "Excludes",
            icon: Icons.cancel,
            children: tour['excludes']
                .map<Widget>((item) => _buildBulletPoint(item['name']))
                .toList(),
          ),
          _buildSectionCard(
            title: "Cancellation Policy",
            icon: Icons.warning,
            children: tour['cancelation_items']
                .map<Widget>((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "- ${item['amount']}% charge if canceled within ${item['days']} days",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ))
                .toList(),
          ),
          _buildSectionCard(
            title: "Hotels",
            icon: Icons.hotel,
            children: tour['tour_hotels']
                .map<Widget>((item) => _buildBulletPoint(item['name']))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          Icon(icon, color: mainColor, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(title, icon),
            const SizedBox(height: 5),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            "$label ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: mainColor),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
