import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class InvoiceVoucherScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const InvoiceVoucherScreen({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Invoice & Voucher'),
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

  Future<String> _generatePDF(BuildContext context) async {
    double rowSpacing = 5.0;

    var selectedText = '';
    if (bookingData['bus'] != null) {
      selectedText = [
        bookingData['bus']?['bus_name'],
        bookingData['bus']?['bus_no']
      ].where((e) => e != null && e.toString().isNotEmpty).join(' - ');
    } else if (bookingData['flight'] != null) {
      selectedText = [
        bookingData['flight']?['flight_type'],
        bookingData['flight']?['flight_class'],
        bookingData['flight']?['from_to'],
      ].where((e) => e != null && e.toString().isNotEmpty).join(' - ');
    } else if (bookingData['tour'] != null) {
      selectedText = bookingData['tour']!['tour_name'] ?? '';
    } else if (bookingData['visa'] != null) {
      selectedText = bookingData['visa']!['country_name'] ?? '';
    } else if (bookingData['hotel'] != null) {
      selectedText = bookingData['hotel']!['hotel_name'] ?? '';
    }
    final pdf = pw.Document();

    final ByteData data = await rootBundle.load('assets/images/Logo.png');
    final Uint8List yourLogoBytes = data.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  color: PdfColors.blue50,
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        height: 60,
                        width: 60,
                        child: pw.Image(
                          pw.MemoryImage(yourLogoBytes),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                        "Travelta",
                        style: pw.TextStyle(
                            color: const PdfColor.fromInt(0xFF0D47A1),
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  color: const PdfColor.fromInt(0xFF0D47A1),
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Invoice",
                            style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['bus']?['created_at'] ??
                                bookingData['flight']?['created_at'] ??
                                bookingData['tour']?['created_at'] ??
                                bookingData['visa']?['created_at'] ??
                                bookingData['hotel']?['created_at'] ??
                                '',
                            style: const pw.TextStyle(
                                fontSize: 12, color: PdfColors.white),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            "Invoice Date",
                            style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Tuesday, Jul 16, 2024",
                            style: const pw.TextStyle(
                                fontSize: 12, color: PdfColors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  color: PdfColors.white,
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Booking ID",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: const PdfColor.fromInt(0xFF0D47A1),
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        bookingData['bus']?['code'] ??
                            bookingData['flight']?['code'] ??
                            bookingData['tour']?['code'] ??
                            bookingData['visa']?['code'] ??
                            bookingData['hotel']?['code'] ??
                            '',
                        style: const pw.TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromInt(0xFF0D47A1),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Divider(),
                pw.Container(
                  color: PdfColors.white,
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "To,",
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['bus']?['to_name'] ??
                                bookingData['flight']?['to_name'] ??
                                bookingData['tour']?['to_name'] ??
                                bookingData['visa']?['to_name'] ??
                                bookingData['hotel']?['to_name'] ?? 
                                '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['bus']?['to_email'] ??
                                bookingData['flight']?['to_email'] ??
                                bookingData['tour']?['to_email'] ??
                                bookingData['visa']?['to_email'] ??
                                bookingData['hotel']?['to_email'] ??
                                '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['bus']?['to_phone'] ??
                                bookingData['flight']?['to_phone'] ??
                                bookingData['tour']?['to_phone'] ??
                                bookingData['visa']?['to_phone'] ??
                                bookingData['hotel']?['to_phone'] ??
                                '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "From,",
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['agent_data']?['name'] ?? '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['agent_data']?['email'] ?? '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            bookingData['agent_data']?['phone'] ?? '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Divider(),
                pw.Container(
                  color: PdfColors.white,
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              selectedText,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: const PdfColor.fromInt(0xFF0D47A1),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              bookingData['tour']?['tour_hotels'][0]
                                      ['hotel_name'] ??
                                  '',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: const PdfColor.fromInt(0xFF0D47A1),
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: rowSpacing),
                      _buildRow(
                          "Check In",
                          bookingData['visa']?['travel_date'] ??
                              bookingData['hotel']?['check_in'] ??
                              bookingData['bus']?['depature'] ??
                              bookingData['flight']?['depature'] ??
                              bookingData['tour']?['tour_hotels'][0]
                                  ['check_in'] ??
                              ''),
                      pw.SizedBox(height: rowSpacing),
                      _buildRow(
                          "Check Out",
                          bookingData['visa']?['appointment'] ??
                              bookingData['hotel']?['check_out'] ??
                              bookingData['bus']?['arrival'] ??
                              bookingData['flight']?['arrival'] ??
                              bookingData['tour']?['tour_hotels'][0]
                                  ['check_out'] ??
                              ''),
                      pw.SizedBox(height: rowSpacing),
                      _buildRow(
                          bookingData['flight'] != null
                              ? "Ticket No."
                              : bookingData['bus'] != null
                                  ? "From"
                                  : "Total Nights",
                          bookingData['hotel']?['no_nights'] ??
                              bookingData['bus']?['from'] ??
                              bookingData['flight']?['ticket_no'] ??
                              bookingData['tour']?['tour_hotels'][0]
                                  ['nights'] ??
                              ''),
                      pw.SizedBox(height: rowSpacing),
                      _buildRow(
                          bookingData['flight'] != null
                              ? "Airline / Ref PNR"
                              : bookingData['bus'] != null
                                  ? "To"
                                  : "No. of Rooms",
                          bookingData['hotel']?['room_type'] ??
                              bookingData['bus']?['to'] ??
                              bookingData['tour']?['tour_hotels'][0]
                                  ['room_type'] ??
                              [
                                bookingData['flight']?['airline'],
                                bookingData['flight']?['ref_pnr']
                              ]
                                  .where((e) =>
                                      e != null && e.toString().isNotEmpty)
                                  .join(' - ') ??
                              ''),
                      pw.SizedBox(height: rowSpacing),
                      _buildRow(
                          "No. of Adults",
                          bookingData['hotel']?['no_adults'].toString() ??
                              bookingData['bus']?['no_adults'].toString() ??
                              bookingData['flight']?['adults_no'].toString() ??
                              bookingData['tour']?['adults_no'].toString() ??
                              ''),
                      pw.SizedBox(height: rowSpacing),
                      _buildRow(
                          "No. of Children",
                          bookingData['hotel']?['no_children'].toString() ??
                              bookingData['bus']?['no_children'].toString() ??
                              bookingData['flight']?['children_no']
                                  .toString() ??
                              bookingData['tour']?['children_no'].toString() ??
                              ''),
                      if (bookingData['tour'] != null) ...[
                        pw.SizedBox(height: rowSpacing),
                        _buildRow(
                            "Transportation",
                            bookingData['tour']?['tour_buses'][0]
                                    ['transportation'] ??
                                ''),
                        pw.SizedBox(height: rowSpacing),
                        _buildRow(
                            "No. of Seats",
                            bookingData['tour']?['tour_buses'][0]['seats']
                                    .toString() ??
                                ''),
                      ],
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  color: PdfColors.blue50,
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Row(
                    children: [
                      pw.Text("Payment Details",
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Total Amount",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor.fromInt(0xFF0D47A1),
                      ),
                    ),
                    pw.Text(
                      bookingData['bus']?['total_price'] ??
                          bookingData['flight']?['total_price'] ??
                          bookingData['tour']?['total_price'] ??
                          bookingData['visa']?['total_price'] ??
                          bookingData['hotel']?['total_price'] ??
                          '',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        color: PdfColor.fromInt(0xFF0D47A1),
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Text(
                  "Our Support Team is always ready to assist you. Please contact us https://login.travelta.online/ Or Call us on +01123456789 for anyassistance or feedback",
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: const PdfColor.fromInt(0xFF0D47A1),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }

    final filePath = '${directory!.path}/Invoice_Voucher.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  Future<void> _viewPDF(BuildContext context) async {
    final filePath = await _generatePDF(context);
    OpenFile.open(filePath);
  }

  Future<void> _sharePDF(BuildContext context) async {
    final filePath = await _generatePDF(context);
    Share.shareXFiles([XFile(filePath)],
        text: 'Here is your Invoice & Voucher.');
  }

  pw.Widget _buildRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: const PdfColor.fromInt(0xFF0D47A1),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColor.fromInt(0xFF0D47A1),
            ),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
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
