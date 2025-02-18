import 'package:flutter/material.dart';

void showImageDialog(BuildContext context, List<String> images) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxHeight: 400), // Limits height for scrolling
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("All Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(image, width: 250, height: 150, fit: BoxFit.cover),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}