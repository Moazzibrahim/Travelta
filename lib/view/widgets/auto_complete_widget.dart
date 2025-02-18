import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class AutoCompleteWidget extends StatelessWidget {
  const AutoCompleteWidget({super.key, required this.hintText, required this.options, required this.onSelected, required this.onChange});
  final String hintText;
  final List<Map<String, dynamic>> options;
  final Function(Map<String, dynamic>) onSelected;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Map<String, dynamic>>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text.isEmpty) {
        return const Iterable<Map<String, dynamic>>.empty();
      }
      return options.where((option) => 
        option['name'].toLowerCase().startsWith(textEditingValue.text.toLowerCase())
      );
    },
    displayStringForOption: (option) => option['name'],
    onSelected: onSelected,
    fieldViewBuilder: (BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted) {
      return TextField(
        controller: fieldTextEditingController,
        onChanged: onChange,
        focusNode: fieldFocusNode,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      );
    },
    optionsViewBuilder: (BuildContext context,
        AutocompleteOnSelected<Map<String, dynamic>> onSelected,
        Iterable<Map<String, dynamic>> options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white, // White background
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 250, // Limit the height
              maxWidth: MediaQuery.of(context).size.width - 32,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> option = options.elementAt(index);
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(option['icon'], color: mainColor),
                      title: Text(option['name'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      subtitle: Text(option['type'],
                          style: TextStyle(color: Colors.grey.shade600)),
                      onTap: () {
                        onSelected(option);
                      },
                    ),
                    if (index != options.length - 1) 
                      Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
  }
}