import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<String> generatePdf(
      String fileName, Map<String, dynamic>? responseData) async {
    final pdf = pw.Document();
    final ByteData data = await rootBundle.load('assets/images/Logo.png');
    final Uint8List yourLogoBytes = data.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(20),
            child: pw.Column(
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
                            DateFormat('yyyy/MM/dd -- HH:mm').format(
                                DateTime.parse(
                                    responseData!['tour']['created_at'])),
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Container(
                    color: PdfColors.white,
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Row(
                      children: [
                        pw.Column(
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
                              responseData['tour']['code'],
                              style: const pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xFF0D47A1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
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
                            responseData['tour']['to_name'],
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            responseData['tour']['to_email'],
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            responseData['tour']['to_phone'],
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
                            responseData['tour']['tour']['agent']['name'],
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            responseData['tour']['tour']['agent']['email'],
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFF0D47A1),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            responseData['tour']['tour']['agent']['phone'],
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
                buildRow('tour name', responseData['tour']['tour']['name']),
                buildRow('tour description',
                    responseData['tour']['tour']['description']),
                buildRow('tour nights',
                    responseData['tour']['tour']['nights'].toString()),
                buildRow(
                    'hotel name',
                    responseData['tour']['book_tour_room'][0]['to_hotel']
                        ['name']),
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
                      "${responseData['tour']['total_price']} ${responseData['tour']['currency']['name']}",
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

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static pw.Widget buildRow(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
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
      ),
    );
  }
}
