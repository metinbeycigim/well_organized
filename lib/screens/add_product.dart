import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/consants/text_editing_controllers.dart';
import 'package:well_organized/consants/titles.dart';
import 'package:well_organized/models/product_model.dart';
import 'package:well_organized/services/riverpod_service.dart';
import 'package:well_organized/widgets/build_text_field.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Titles.addProductScreenTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BuildTextField(('Product Name'), 'Enter the product name', TextEditingControllers.productNameController),
              BuildTextField(('SKU'), 'Enter a SKU', TextEditingControllers.skuController),
              BuildTextField(('Location'), 'Enter the location', TextEditingControllers.locationController),
              BuildTextField(('Barcode'), 'Enter Barcode', TextEditingControllers.barcodeController),
              BuildTextField(('Quantity'), 'Enter the quantity', TextEditingControllers.quantityController),
              BuildTextField(('Photo1'), 'Photo placeholder', TextEditingControllers.photoController),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    final userName =
                        ref.read(RiverpodService.firebaseAuthProvider).firebaseAuth.currentUser!.displayName as String;
                    final ProductModel product = ProductModel(
                        userName: userName,
                        productName: TextEditingControllers.productNameController.text,
                        sku: TextEditingControllers.skuController.text,
                        location: TextEditingControllers.locationController.text,
                        barcode: TextEditingControllers.barcodeController.text,
                        quantity: int.parse(TextEditingControllers.quantityController.text),
                        photo1: TextEditingControllers.photoController.text);
                    void clearTextFields() {
                      TextEditingControllers.productNameController.clear();
                      TextEditingControllers.skuController.clear();
                      TextEditingControllers.locationController.clear();
                      TextEditingControllers.barcodeController.clear();
                      TextEditingControllers.quantityController.clear();
                      TextEditingControllers.photoController.clear();
                    }

                    await ref.read(RiverpodService.firebaseDatabaseProvider).addProduct(product);
                    clearTextFields();
                  },
                  child: const Text(
                    'AddProduct',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
