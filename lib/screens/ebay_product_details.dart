import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/models/ebay_product_model.dart' hide Image;
import 'package:well_organized/widgets/add_space.dart';

class EbayProductDetail extends ConsumerWidget {
  final ItemSummary product;
  const EbayProductDetail(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ebay Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.thumbnailImages![0].imageUrl,
            ),
            verticalSpace(5),
            ListTile(
              leading: Text('${product.price.currency} ${product.price.value}'),
              title: Text(product.title),
            ),
            verticalSpace(5),
            product.shippingOptions![0].shippingCost.value == '0.00'
                ? const Text('Free Shipping')
                : Text(
                    'Shipping Cost: ${product.shippingOptions![0].shippingCost.currency} ${product.shippingOptions![0].shippingCost.value}'),
            verticalSpace(5),
            Text('Condition : ${product.condition}'),
            verticalSpace(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seller : ${product.seller.username}'),
                horizontalSpace(5),
                Text('%${product.seller.feedbackPercentage} / ${product.seller.feedbackScore}'),
                horizontalSpace(2),
                if (product.topRatedBuyingExperience == true) const Icon(Icons.stars_sharp),
              ],
            )
          ],
        ),
      ),
    );
  }
}
