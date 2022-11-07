import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class QrPrint extends ConsumerStatefulWidget {
  final String qrData;
  const QrPrint(this.qrData, {super.key});

  static const routeName = '/qrPrint';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrPrintState();
}

class _QrPrintState extends ConsumerState<QrPrint> {
// Page

  @override
  Widget build(BuildContext context) {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.BarcodeWidget(barcode: pw.Barcode.fromType(pw.BarcodeType.QrCode), data: widget.qrData),
          ); // Center
        }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer'),
      ),
      body: Column(
        children: [
          Center(
            child: widget.qrData == ' '
                ? const Text('No product')
                : SizedBox(
                    height: 170,
                    child: SfBarcodeGenerator(
                      value: widget.qrData,
                      symbology: QRCode(),
                    ),
                  ),
          ),
          ElevatedButton(
              onPressed: () async {
                await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
              },
              child: const Text('Print'))
        ],
      ),
    );
  }
}
