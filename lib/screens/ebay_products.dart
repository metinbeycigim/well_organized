import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/services/ebay_api.dart';

class EbayProducts extends ConsumerStatefulWidget {
  const EbayProducts({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EbayProductsState();
}

class _EbayProductsState extends ConsumerState<EbayProducts> {
  String upc = '0026508267042';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => EbayApi().getProductByUpc(upc),
          child: const Text('Get Product Data'),
        ),
      ),
    );
  }
}
