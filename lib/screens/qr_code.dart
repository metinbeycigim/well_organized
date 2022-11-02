import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:well_organized/models/app_product_model.dart';
import 'package:well_organized/services/firebase_database_service.dart';

class QrCode extends ConsumerStatefulWidget {
  const QrCode({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrCodeState();
}

class _QrCodeState extends ConsumerState<QrCode> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AsyncValue<QuerySnapshot<Map<String, dynamic>>> productRef;

  @override
  void didChangeDependencies() {
    productRef = ref.watch(FirebaseDatabaseService.firebaseProductListProvider);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('QR Code'),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UPC',
                    hintText: 'Enter a valid UPC',
                  ),
                  validator: ((value) {
                    if (value!.isEmpty && value.length < 12) {
                      return 'Enter a valid barcode';
                    } else {
                      return null;
                    }
                  }),
                  onChanged: ((value) => setState(() {})),
                ),
              ),
            ),
            if (_textEditingController.text.length >= 11)
              productRef.when(
                  data: (data) {
                    List<AppProductModel> productList = [];
                    for (var snapshot in data.docs) {
                      final product = AppProductModel.fromMap(snapshot.data());
                      productList.add(product);
                    }
                    AppProductModel matchedProduct =
                        productList.where((element) => element.barcode == _textEditingController.text).first;
                    String qrData = '${matchedProduct.sku} ${matchedProduct.location}';

                    return Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: SfBarcodeGenerator(
                            value: qrData,
                            symbology: QRCode(),
                          ),
                        ),
                        Text(
                          qrData,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () => context.push('/qrPrint', extra: qrData),
                            child: const Text('Print'),
                          ),
                        ),
                      ],
                    );
                  },
                  error: ((error, stackTrace) => const Center(child: Text('error'))),
                  loading: () => const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
