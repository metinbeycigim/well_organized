import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/constants/extensions.dart';
import 'package:well_organized/models/app_product_model.dart';
import 'package:well_organized/services/firebase_database_service.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  final TextEditingController _controller = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listViewData = [];
  late AsyncValue<QuerySnapshot<Map<String, dynamic>>> productsRef;

  @override
  void didChangeDependencies() {
    productsRef = ref.watch(FirebaseDatabaseService.firebaseProductListProvider);
    super.didChangeDependencies();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Center(
        child: productsRef.when(
          data: (data) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> productList = data.docs;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Form(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Enter a search term',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: ((value) {
                        final list = productList
                            .where((element) =>
                                AppProductModel.fromMap(element.data())
                                    .sku
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                AppProductModel.fromMap(element.data())
                                    .location
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                AppProductModel.fromMap(element.data())
                                    .productName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();

                        if (list.isNotEmpty) {
                          setState(() {
                            listViewData = list;
                          });
                        }
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: productList.isNotZero().isNotEmpty
                        ? ListView.builder(
                            itemBuilder: ((_, index) {
                              final productsQuantityNotZero = productList.isNotZero().toList();
                              final product = _controller.text.isEmpty
                                  ? AppProductModel.fromMap(productsQuantityNotZero[index].data())
                                  : AppProductModel.fromMap(listViewData[index].data());

                              return ListTile(
                                leading: Text(product.sku.toUpperCase()),
                                title: Text(product.productName),
                                subtitle: Text('location: ${product.location}'),
                                trailing: Text(product.quantity.toString()),
                              );
                            }),
                            itemCount: _controller.text.isEmpty
                                ? productList.isNotZero().length
                                : listViewData.isNotZero().length,
                          )
                        : const Center(
                            child: Text('No product'),
                          ),
                  ),
                ),
              ],
            );
          },
          error: ((error, stackTrace) => const Text('error')),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
