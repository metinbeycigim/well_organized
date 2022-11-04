import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/screens/ebay_product_details.dart';
import 'package:well_organized/services/ebay_api.dart';

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

    const String testUpcGood = '014817483499';
    const String testUpcBad = '0849376002160';
    const String testUpcBad2 = '50885785091062'; //itemsummaries null
    const String testMissingMap = '017801809879';

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Ebay Products')),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
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
                        if (data.total != 0) {
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.itemSummaries.length,
                                itemBuilder: (context, index) {
                                  data.itemSummaries.sort(((a, b) => a.price.value.compareTo(b.price.value)));
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => EbayProductDetail(data.itemSummaries[index])))),
                                        leading: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Text(
                                                '${data.itemSummaries[index].price.currency} ${data.itemSummaries[index].price.value}'),
                                            if (data.itemSummaries[index].topRatedBuyingExperience == true)
                                              const Positioned(
                                                top: -15,
                                                left: -10,
                                                child: Icon(Icons.stars_sharp),
                                              ),
                                          ],
                                        ),
                                        title: Text(
                                          data.itemSummaries[index].title,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: AppColors.textColor,
                                        indent: 70,
                                        endIndent: 70,
                                      ),
                                    ],
                                  );
                                }),
                          );
                        }
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              'No product!\nIt still may be exist on Ebay',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
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
