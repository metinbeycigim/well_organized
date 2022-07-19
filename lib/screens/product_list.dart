import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/models/product_model.dart';
import 'package:well_organized/services/riverpod_service.dart';

import '../widgets/back_to_home_screen.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  @override
  Widget build(BuildContext context) {
    final productsRef = ref.watch(RiverpodService.firebaseProductListProvider);
    return Scaffold(
        appBar: AppBar(
          leading: const BackToHomeScreen(),
          title: const Text('Product List'),
        ),
        body: Center(
          child: productsRef.when(
            data: (data) {
              return ListView.builder(
                itemBuilder: ((_, index) {
                  final product = ProductModel.fromMap(data.docs[index].data());
                  return ListTile(
                    leading: Text(product.sku),
                    title: Text(product.productName),
                    subtitle: Text(product.location),
                    trailing: Text(product.quantity.toString()),
                  );
                }),
                itemCount: data.docs.length,
              );
            },
            error: ((error, stackTrace) => const Text('error')),
            loading: () => const CircularProgressIndicator(),
          ),
        ));
  }
}
