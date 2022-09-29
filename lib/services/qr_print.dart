import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
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
  final PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _deviceMsg = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as QrData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Printers'),
      ),
      body: _devices.isEmpty
          ? Center(
              child: Text(_deviceMsg),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.print),
                  title: Text(_devices[index].name!),
                  subtitle: Text(_devices[index].address!),
                  onTap: () {
                    _startPrint(_devices[index]);
                  },
                );
              }),
    );
  }

  void initPrinter() {
    _printerManager.startScan(const Duration(seconds: 5));
    _printerManager.scanResults.listen((value) {
      if (!mounted) return;
      setState(() => _devices = value);
      print(_devices);
      if (_devices.isEmpty) {
        setState(() => _deviceMsg = 'No devices');
      }
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    final list = await _ticket().then((value) => value);
    _printerManager.selectPrinter(printer);
    print(list);
    final result = await _printerManager.printTicket(list);
  }

  Future<List<int>> _ticket() async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.text('test');
    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }
}
