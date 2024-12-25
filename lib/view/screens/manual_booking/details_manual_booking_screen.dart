// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/screens/manual_booking/from_manual_booking_screen.dart';
import 'package:flutter_travelta/view/screens/manual_booking/to_manual_booking_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';

class DetailsManualBookingScreen extends StatelessWidget {
  const DetailsManualBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Manual booking"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepperColumn(
                  label: "To",
                  isCompleted: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ToManualBookingScreen()));
                  },
                ),
                Expanded(child: Divider(color: mainColor, thickness: 1)),
                _buildStepperColumn(
                  label: "From",
                  isCompleted: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FromManualBookingScreen()));
                  },
                ),
                const Expanded(
                    child: Divider(color: Colors.grey, thickness: 1)),
                _buildStepperColumn(
                  label: "Details",
                  isCompleted: true,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Booking Details Section
            _buildSectionTitle('Booking Details'),
            _buildTextFieldWithIcon('Check In:', Icons.calendar_today, context),
            const SizedBox(height: 16),
            _buildTextFieldWithIcon(
                'Check Out:', Icons.calendar_today, context),
            const SizedBox(height: 16),
            _buildTextField('Total (Night):'),
            const SizedBox(height: 32),

            // Hotel Information Section
            _buildSectionTitle('Hotel Information'),
            _buildTextField('Hotel Name:'),
            const SizedBox(height: 16),
            _buildTextField('Room Type:'),
            const SizedBox(height: 16),
            _buildTextField('Room Quantity:'),
            const SizedBox(height: 32),

            // Guests Section
            _buildSectionTitle('Guests'),
            _buildDropdownField('Adults:'),
            const SizedBox(height: 16),
            _buildDropdownField('Children:'),
            const SizedBox(height: 16),
            _buildDropdownField('Total Price:'),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: mainColor,
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
    String label, IconData icon, BuildContext context) {
  return TextField(
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(), // Restrict past dates
        lastDate: DateTime(2100), // Maximum year selectable
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: mainColor, // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: mainColor, // Button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
        print(
            'Selected Date: $formattedDate'); // Replace with your logic to display the selected date
      }
    },
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: Icon(icon, color: mainColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: mainColor),
      ),
    ),
  );
}


  Widget _buildDropdownField(String label) {
    return DropdownButtonFormField<String>(
      items: const [],
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: mainColor),
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
