import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/screens/qr_code.dart';

class QrPrint extends ConsumerStatefulWidget {
  const QrPrint({Key? key}) : super(key: key);

  static const routeName = '/qrPrint';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrPrintState();
}

class _QrPrintState extends ConsumerState<QrPrint> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as QrData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Printers'),
      ),
      body: Center(
        child: Text(args.qrData),
      ),
    );
  }
}
