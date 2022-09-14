import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/widgets/add_space.dart';

class EbayProductDetail extends ConsumerWidget {
  final Map<String, dynamic> upc;
  const EbayProductDetail(this.upc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ebay Product Detail'),
      ),
      body: Column(
        children: [
          Image.network(
            upc['thumbnailImages'][0]['imageUrl'],
          ),
          ListTile(
            leading: Text(upc['price']['currency'] + ' ' + upc['price']['value']),
            title: Text(upc['title']),
          ),
          verticalSpace(10),
          upc['shippingOptions'][0]['shippingCost']['value'] == '0.00'
              ? const Text('Free Shipping')
              : Text(upc['shippingOptions'][0]['shippingCost']['value']),
        ],
      ),
    );
  }
}
