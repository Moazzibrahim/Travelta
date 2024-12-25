import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/screens/manual_booking/details_manual_booking_screen.dart';
import 'package:flutter_travelta/view/screens/manual_booking/from_manual_booking_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';

class ToManualBookingScreen extends StatelessWidget {
  const ToManualBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Manual booking"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator using _buildStepperColumn
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepperColumn(
                  label: 'To',
                  isCompleted: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ToManualBookingScreen(),
                      ),
                    );
                  },
                ),
                const Expanded(
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
                _buildStepperColumn(
                  label: 'From',
                  isCompleted: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FromManualBookingScreen(),
                      ),
                    );
                  },
                ),
                const Expanded(
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
                _buildStepperColumn(
                  label: 'Details',
                  isCompleted: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DetailsManualBookingScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // B2B Input
            TextField(
              decoration: InputDecoration(
                labelText: 'B2B',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Supplier Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Supplier:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Supplier 1',
                  child: Text('Supplier 1'),
                ),
                DropdownMenuItem(
                  value: 'Supplier 2',
                  child: Text('Supplier 2'),
                ),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            // Add Supplier Button
            TextButton(
              onPressed: () {},
              child: Text(
                '+ Add Supplier',
                style: TextStyle(color: mainColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperColumn({
    required String label,
    bool isCompleted = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? mainColor : Colors.white,
              border: Border.all(color: isCompleted ? mainColor : Colors.grey),
            ),
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isCompleted ? mainColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
