import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';

class BookingPaymentScreen extends StatelessWidget {
  const BookingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Booking Payment'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildBookingCard(
              bookingId: '202412001',
              customerName: 'Ahmed Mohamed',
              totalAmount: '3,000 EGP',
              amountPaid: '1,500 EGP',
              amountRemaining: '1,500 EGP',
              paymentMethod: 'Credit Card',
              paymentDate: '2024-12-01',
              paymentStatus: 'Fully Paid',
              statusColor: const Color.fromRGBO(233, 246, 236, 1),
            ),
            const SizedBox(height: 16.0),
            buildBookingCard(
              bookingId: '202412002',
              customerName: 'Ahmed Mohamed',
              totalAmount: '3,000 EGP',
              amountPaid: '1,500 EGP',
              amountRemaining: '1,500 EGP',
              paymentMethod: 'Bank Transfer',
              paymentDate: '2024-12-02',
              paymentStatus: 'Pending',
              statusColor: const Color.fromRGBO(233, 246, 236, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookingCard({
    required String bookingId,
    required String customerName,
    required String totalAmount,
    required String amountPaid,
    required String amountRemaining,
    required String paymentMethod,
    required String paymentDate,
    required String paymentStatus,
    required Color statusColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: const Color.fromRGBO(231, 237, 246, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAlignedRow('Booking ID:', bookingId),
                const SizedBox(height: 8.0),
                buildAlignedRow('Customer Name:', customerName),
                const SizedBox(height: 8.0),
                buildAlignedRow('Total Amount:', totalAmount),
                const SizedBox(height: 8.0),
                buildAlignedRow('Amount Paid:', amountPaid),
                const SizedBox(height: 8.0),
                buildAlignedRow('Amount Remaining:', amountRemaining),
                const SizedBox(height: 8.0),
                buildAlignedRow('Payment Method:', paymentMethod),
                const SizedBox(height: 8.0),
                buildAlignedRow('Payment Date:', paymentDate),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Payment Status:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        paymentStatus,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(231, 237, 246, 1),
                    side: BorderSide(color: mainColor, width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: mainColor),
                  label: Text(
                    'Delete',
                    style: TextStyle(fontSize: 16, color: mainColor),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAlignedRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
