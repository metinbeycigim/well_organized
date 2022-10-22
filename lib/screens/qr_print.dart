import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class QrPrint extends ConsumerStatefulWidget {
  final String qrData;
  const QrPrint(this.qrData, {super.key});

  static const routeName = '/qrPrint';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrPrintState();
}

class _QrPrintState extends ConsumerState<QrPrint> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printers'),
      ),
      body: Center(
        child: Text(widget.qrData),
      ),
    );
  }
}
