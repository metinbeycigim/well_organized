import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:well_organized/services/save_excel_file.dart';

import '../models/product_model.dart';
import '../services/riverpod_service.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

      // does not include quantity = 0 items
      void setList(List<QueryDocumentSnapshot<Map<String, dynamic>>>? productList,
          void Function(String cell, String content) setSellContent) {
        final products = productList!.where((element) => ProductModel.fromMap(element.data()).quantity > 0).toList();
        for (var i = 0; i < products.length; i++) {
          final modelFirebase = ProductModel.fromMap(products[i].data());
          setCellContent('A${i + 2}', modelFirebase.barcode);
          setCellContent('B${i + 2}', modelFirebase.sku);
          setCellContent('C${i + 2}', modelFirebase.location);
          setCellContent('D${i + 2}', modelFirebase.productName);
          setCellContent('E${i + 2}', modelFirebase.quantity.toString());
          setCellContent('F${i + 2}', modelFirebase.photo1 ?? '');
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
        title: const Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: generateExcel,
          child: const Text('Export Product List'),
        ),
      ),
    );
  }
}
