import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:well_organized/constants/text_editing_controllers.dart';
import 'package:well_organized/constants/titles.dart';

import '../models/product_model.dart';
import '../services/riverpod_service.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  void clearTextFields() {
    TextEditingControllers.productNameController.clear();
    TextEditingControllers.skuController.clear();
    TextEditingControllers.locationController.clear();
    TextEditingControllers.barcodeController.clear();
    TextEditingControllers.quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseStorageRef = FirebaseStorage.instance.ref();
    final productImage = firebaseStorageRef.child(TextEditingControllers.skuController.text.trim().toUpperCase());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Titles.addProductScreenTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: TextEditingControllers.productNameController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                    hintText: 'Enter the product name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: TextEditingControllers.skuController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'SKU',
                    hintText: 'Enter an SKU',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: TextEditingControllers.locationController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                    hintText: 'Enter the location',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: TextEditingControllers.barcodeController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Barcode',
                    hintText: 'Barcode',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: TextEditingControllers.quantityController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    hintText: 'Enter the quantity',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: TextEditingControllers.skuController.text.isNotEmpty &&
                          TextEditingControllers.productNameController.text.isNotEmpty &&
                          TextEditingControllers.locationController.text.isNotEmpty &&
                          TextEditingControllers.barcodeController.text.isNotEmpty &&
                          TextEditingControllers.quantityController.text.isNotEmpty
                      ? () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          final imageFile = File(image!.path);

                          try {
                            await productImage.putFile(imageFile);
                          } on FirebaseException catch (e) {
                            print(e);
                          }
                        }
                      : null,
                  child: const Icon(Icons.photo_camera),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    final photoURL = await productImage.getDownloadURL();
                    final userName =
                        ref.read(RiverpodService.firebaseAuthProvider).firebaseAuth.currentUser!.displayName as String;
                    ProductModel product = ProductModel(
                      userName: userName,
                      productName: TextEditingControllers.productNameController.text,
                      sku: TextEditingControllers.skuController.text,
                      location: TextEditingControllers.locationController.text,
                      barcode: TextEditingControllers.barcodeController.text,
                      quantity: int.parse(TextEditingControllers.quantityController.text),
                      photo1: photoURL,
                      photo2: null,
                      photo3: null,
                    );

                    try {
                      await ref.read(RiverpodService.firebaseDatabaseProvider).addProduct(product);
                      clearTextFields();
                    } catch (e) {
                      print('Error: $e');
                    }
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
