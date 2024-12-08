import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OperationScreenState createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Operation'
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Card
            buildOperationCard(
              index: 0,
              operationId: "OP12345",
              clientName: "Sara Hassan",
              status: "Pending",
              statusColor: Colors.orange.shade100,
              statusTextColor: Colors.orange.shade700,
            ),
            const SizedBox(height: 16.0),

            // Second Card
            buildOperationCard(
              index: 1,
              operationId: "OP12346",
              clientName: "Ali Ahmed",
              status: "Confirmed",
              statusColor: Colors.green.shade100,
              statusTextColor: Colors.green.shade700,
            ),
            const SizedBox(height: 16.0),

            // Third Card
            buildOperationCard(
              index: 2,
              operationId: "OP12347",
              clientName: "Zara Khan",
              status: "Active",
              statusColor: mainColor,
              statusTextColor: Colors.white,
            ),
            const SizedBox(height: 32.0),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Update',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOperationCard({
    required int index,
    required String operationId,
    required String clientName,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: selectedCardIndex == index
              ? const Color.fromRGBO(255, 255, 255, 1)
              : const Color.fromRGBO(231, 237, 246, 1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: selectedCardIndex == index
                ? mainColor
                : (borderColor ?? Colors.transparent),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Operation ID: $operationId',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Client Name: $clientName',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontSize: 16.0),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
