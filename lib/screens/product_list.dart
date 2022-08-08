import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;
import 'package:well_organized/constants/extensions.dart';
import 'package:well_organized/models/product_model.dart';
import 'package:well_organized/services/riverpod_service.dart';

import '../utils/save_excel_file.dart';
import '../widgets/back_to_home_screen.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  final TextEditingController _controller = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listViewData = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsRef = ref.watch(RiverpodService.firebaseProductListProvider);

    Future<void> generateExcel() async {
      //Creating a workbook.
      final Workbook workbook = Workbook();

      //Accessing via index
      final Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'Product List';

      sheet.showGridlines = true;

      void setCellContent(String cell, String content) {
        sheet.getRangeByName(cell).setText(content);
      }

      setCellContent('A1', 'Barcode');
      setCellContent('B1', 'SKU');
      setCellContent('C1', 'Location');
      setCellContent('D1', 'Product Name');
      setCellContent('E1', 'Qty');
      setCellContent('F1', 'Photo-1');
      setCellContent('G1', 'Photo-2');
      setCellContent('H1', 'Photo-3');
      setCellContent('I1', 'User Name');

      void setList(List<QueryDocumentSnapshot<Map<String, dynamic>>>? productList,
          void Function(String cell, String content) setSellContent) {
        for (var i = 0; i < productList!.length; i++) {
          final modelFirebase = ProductModel.fromMap(productList[i].data());
          setCellContent('A${i + 2}', modelFirebase.barcode);
          setCellContent('B${i + 2}', modelFirebase.sku);
          setCellContent('C${i + 2}', modelFirebase.location);
          setCellContent('D${i + 2}', modelFirebase.productName);
          setCellContent('E${i + 2}', modelFirebase.quantity.toString());
          setCellContent('F${i + 2}', modelFirebase.photo1);
          setCellContent('G${i + 2}', modelFirebase.photo2 ?? '');
          setCellContent('H${i + 2}', modelFirebase.photo3 ?? '');
          setCellContent('I${i + 2}', modelFirebase.userName);
        }
      }

      final productList = productsRef.whenData((value) => value.docs).value;
      setList(productList, setCellContent);

      //Save and launch the excel
      final List<int> bytes = workbook.saveAsStream();
      //Dispose the document.
      workbook.dispose();

      //Save and launch the file.
      await saveAndLaunchFile(bytes,
              'Product List-${DateFormat('MM.dd.yy-h:ma').format(DateTime.parse(DateTime.now().toString()))}.xlsx')
          .then((_) => ref.watch(RiverpodService.firebaseDatabaseProvider).firebaseProductRef.get().then((snapshot) {
                for (var doc in snapshot.docs) {
                  doc.reference.update({'quantity': 0});
                }
              }));
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackToHomeScreen(),
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: generateExcel,
            icon: const Icon(Icons.email_sharp),
          ),
        ],
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
                                ProductModel.fromMap(element.data()).sku.toLowerCase().contains(value.toLowerCase()) ||
                                ProductModel.fromMap(element.data())
                                    .location
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                ProductModel.fromMap(element.data())
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
                    child: productList.zeroQuantityProducts().isNotEmpty
                        ? ListView.builder(
                            itemBuilder: ((_, index) {
                              final product = _controller.text.isEmpty
                                  ? ProductModel.fromMap(productList[index].data())
                                  : ProductModel.fromMap(listViewData[index].data());

                              return ListTile(
                                leading: Text(product.sku),
                                title: Text(product.productName),
                                subtitle: Text('location: ${product.location}'),
                                trailing: Text(product.quantity.toString()),
                              );
                            }),
                            itemCount: _controller.text.isEmpty
                                ? productList.zeroQuantityProducts().length
                                : listViewData.zeroQuantityProducts().length,
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
