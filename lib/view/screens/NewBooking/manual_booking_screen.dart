import 'package:flutter/material.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import '../../../constants/colors.dart';

class ManualBookingScreen extends StatelessWidget {
  const ManualBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Manual Booking'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(label: "Name"),
            const SizedBox(height: 20),
            _buildTextField(label: "Email"),
            const SizedBox(height: 20),
            _buildTextField(label: "Phone Number"),
            const SizedBox(height: 20),
            _buildDropdownField(label: "Service Type"),
            const SizedBox(height: 20),
            _buildDateField(label: "Start Date"),
            const SizedBox(height: 20),
            _buildDateField(label: "End Date"),
            const SizedBox(height: 20),
            _buildDropdownField(label: "Payment Method"),
            const SizedBox(height: 32),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Done",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label}) {
    return TextField(
      enabled: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String label}) {
    return DropdownButtonFormField<String>(
      iconDisabledColor: mainColor,
      iconEnabledColor: mainColor,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
      items: const [
        DropdownMenuItem(value: "Option 1", child: Text("Option 1")),
        DropdownMenuItem(value: "Option 2", child: Text("Option 2")),
      ],
      onChanged: (value) {},
    );
  }

  Widget _buildDateField({required String label}) {
    return TextField(
      readOnly: true,
      enabled: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: mainColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
