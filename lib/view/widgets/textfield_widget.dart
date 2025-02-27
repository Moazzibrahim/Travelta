import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_travelta/constants/colors.dart';

class AdultDetailsList extends StatelessWidget {
  final int count;
  final List<Map<String, dynamic>> details;
  final Function(int, String, dynamic) onDetailChanged;

  const AdultDetailsList({
    super.key,
    required this.count,
    required this.details,
    required this.onDetailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adult ${index + 1} Details',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: ["MR", "MRS"]
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  value: details[index]["title"],
                  onChanged: (value) => onDetailChanged(index, "title", value),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'First Name',
                  onChanged: (value) =>
                      onDetailChanged(index, "first_name", value),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Last Name',
                  onChanged: (value) =>
                      onDetailChanged(index, "last_name", value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChildDetailsList extends StatelessWidget {
  final int count;
  final List<Map<String, dynamic>> details;
  final Function(int, String, dynamic) onDetailChanged;

  const ChildDetailsList({
    super.key,
    required this.count,
    required this.details,
    required this.onDetailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Child ${index + 1} Details',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Age',
                  isNumeric: true,
                  onChanged: (value) => onDetailChanged(index, "age", value),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'First Name',
                  onChanged: (value) =>
                      onDetailChanged(index, "first_name", value),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Last Name',
                  onChanged: (value) =>
                      onDetailChanged(index, "last_name", value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RoomDetailsCard extends StatelessWidget {
  final int roomQuantity;
  final List<String> roomTypes;
  final List<String?> selectedRoomTypes;
  final Function(int, String?) onRoomTypeChanged;

  const RoomDetailsCard({
    super.key,
    required this.roomQuantity,
    required this.roomTypes,
    required this.selectedRoomTypes,
    required this.onRoomTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (roomQuantity <= 0) return const SizedBox.shrink();

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Room Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: roomQuantity,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Room ${index + 1} Type',
                      border: const OutlineInputBorder(),
                    ),
                    items: roomTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    value: selectedRoomTypes[index],
                    onChanged: (value) => onRoomTypeChanged(index, value),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isNumeric;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.isNumeric = false,
    this.onChanged,
    String? initialValue,
    TextEditingController? controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: mainColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
