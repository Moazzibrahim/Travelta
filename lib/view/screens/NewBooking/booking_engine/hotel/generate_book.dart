import 'dart:io';

import 'package:flutter_travelta/model/book_room.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String> generatePDF(BuildContext context, BookRoom booking) async {
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
              // Header with logo
              pw.Container(
                color: PdfColors.blue50,
                padding: const pw.EdgeInsets.all(10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          height: 60,
                          width: 60,
                          child: pw.Image(pw.MemoryImage(yourLogoBytes)),
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
                    pw.Text(
                      "Consultant: Ami Amin",
                      style: pw.TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              
              // Invoice details
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(color: PdfColors.blue100),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Invoice # 2024/01201"),
                        pw.Text("Agent Ref. No.: 00000"),
                        pw.Text("Booking ID: ${booking.bookId ?? "N/A"}"),
                        pw.Text("Payment Method: On Credit"),
                      ],
                    ),
                    pw.Text(
                      "Invoice Date\nTuesday, Jul 16, 2024",
                      textAlign: pw.TextAlign.right,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),

              // Hotel & Booking Details
              pw.Text("${booking.clientName ?? "Guest"}"),
              pw.Text("Hotel: Villa Zolitude Resort & Spa"),
              pw.Text("Check-In: ${booking.checkIn ?? "N/A"}"),
              pw.Text("Check-Out: ${booking.checkOut ?? "N/A"}"),
              pw.Text("Total Nights: ${booking.noOfNights ?? 1}"),
              pw.Text("No. of Rooms: ${booking.quantity ?? 1}"),
              pw.SizedBox(height: 10),

              // Room Details
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(color: PdfColors.blue100),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Room Details"),
                    pw.Text("Travellers Details"),
                  ],
                ),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("${booking.roomType ?? "Standard Room"}"),
                  pw.Text("${booking.clientName ?? "Guest"}\n${booking.clientEmail ?? "N/A"}"),
                ],
              ),
              pw.SizedBox(height: 10),

              // Payment Details
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(color: PdfColors.blue100),
                child: pw.Text("Payment Details"),
              ),
              pw.Text("Room Rate: USD ${booking.amount?.toStringAsFixed(2) ?? "0.00"}"),
              pw.Text("Total Charges: USD ${booking.amount?.toStringAsFixed(2) ?? "0.00"}"),
              pw.SizedBox(height: 20),
              
              // Footer
              pw.Text("Our support team is ready to assist you. Contact us at info@lookanbook.com"),
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

