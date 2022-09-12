import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/services/ebay_api.dart';
import 'package:well_organized/widgets/add_space.dart';

class EbayProducts extends ConsumerStatefulWidget {
  const EbayProducts({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EbayProductsState();
}

class _EbayProductsState extends ConsumerState<EbayProducts> {
  final TextEditingController upcController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    upcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ebayProduct = ref.watch(ebayProductProvider(upcController.text));

    const String testUpc = '014817483499';
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                verticalSpace(75),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: upcController,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Enter a UPC';
                      } else if (value.length < 12) {
                        return 'UPC can not be less than 12 characters';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UPC',
                      hintText: 'Enter a valid UPC',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Get Product Data'),
                ),
                if (upcController.text.length > 11)
                  ebayProduct.when(
                      data: (data) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.itemSummaries.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(
                                    data.itemSummaries[index].price.currency + data.itemSummaries[index].price.value),
                                title: Text(data.itemSummaries[index].title),
                              );
                            });
                      },
                      error: ((error, stackTrace) => Center(child: Text(error.toString()))),
                      loading: () => const Center(child: CircularProgressIndicator()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
