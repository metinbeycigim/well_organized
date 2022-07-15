import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/models/product_model.dart';

import '../widgets/back_to_home_screen.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  final _productsRef = FirebaseDatabase.instance.ref().child('Products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackToHomeScreen(),
        title: const Text('Product List'),
      ),
      body: FirebaseAnimatedList(
        query: _productsRef,
        itemBuilder: ((context, snapshot, animation, index) {
          final Map<String, dynamic> map = jsonDecode(jsonEncode(snapshot.value));
          final products = ProductModel.fromMap(map);
          return Card(
            elevation: 5,
            child: ListTile(
              leading: Text(products.sku),
              title: Text(products.productName),
              subtitle: Text(products.barcode),
              trailing: Text(products.quantity.toString()),
            ),
          );
        }),
      ),
    );
  }
}
