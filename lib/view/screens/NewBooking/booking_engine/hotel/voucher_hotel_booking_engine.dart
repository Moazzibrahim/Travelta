import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/screens/NewBooking/booking_engine/hotel/generate_book.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class VoucherHotelBookingEngine extends StatelessWidget {
  const VoucherHotelBookingEngine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher & Invoice'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildVoucherCard(context),
            const SizedBox(height: 20),
            _buildInvoiceCard(context),
          ],
        ),
      ),
    );
  }
  Widget _buildInvoiceCard(BuildContext context) {
    return _buildCard(
      icon: Icons.receipt_long_rounded,
      title: 'Invoice',
      onSharePressed: () async {
        await _sharePDF(context);
      },
      onViewPressed: () async {
        await _viewPDF(context);
      },
    );
  }

  Widget _buildVoucherCard(BuildContext context) {
    return _buildCard(
      icon: Icons.confirmation_number_rounded,
      title: 'Voucher',
      onSharePressed: () async {
        await _sharePDF(context);
      },
      onViewPressed: () async {
        await _viewPDF(context);
      },
    );
  }

  Future<void> _viewPDF(BuildContext context) async {
    final bookinProvider = Provider.of<BookingEngineController>(context, listen: false);
    final filePath = await generatePDF(context,bookinProvider.bookRoom);
    OpenFile.open(filePath);
  }


  Future<void> _sharePDF(BuildContext context) async {
    final bookinProvider = Provider.of<BookingEngineController>(context, listen: false);
    final filePath = await generatePDF(context,bookinProvider.bookRoom);
    Share.shareXFiles([XFile(filePath)],
        text: 'Here is your Invoice & Voucher.');
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required VoidCallback onSharePressed,
    required VoidCallback onViewPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: mainColor, size: 28),
              const SizedBox(width: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: onSharePressed,
                  icon: const Icon(Icons.share, size: 22),
                  label: const Text('Share', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: mainColor,
                    side: BorderSide(color: mainColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: onViewPressed,
                  icon: const Icon(Icons.visibility, size: 22),
                  label: const Text('View', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
