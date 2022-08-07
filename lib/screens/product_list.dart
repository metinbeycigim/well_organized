import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;
import 'package:well_organized/models/product_model.dart';
import 'package:well_organized/services/riverpod_service.dart';

import '../services/save_excel_file.dart';
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
      await saveAndLaunchFile(
          bytes, 'Product List-${DateFormat('MM.dd.yy-h:ma').format(DateTime.parse(DateTime.now().toString()))}.xlsx');
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
            return ListView.builder(
              itemBuilder: ((_, index) {
                final product = ProductModel.fromMap(data.docs[index].data());
                return ListTile(
                  leading: Text(product.sku),
                  title: Text(product.productName),
                  subtitle: Text('location: ${product.location}'),
                  trailing: Text(product.quantity.toString()),
                );
              }),
              itemCount: data.docs.length,
            );
          },
          error: ((error, stackTrace) => const Text('error')),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
