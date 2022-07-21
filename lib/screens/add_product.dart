import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:well_organized/constants/titles.dart';
import 'package:well_organized/widgets/back_to_home_screen.dart';

import '../models/product_model.dart';
import '../services/riverpod_service.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clearTextFields() {
    productNameController.clear();
    skuController.clear();
    locationController.clear();
    barcodeController.clear();
    quantityController.clear();
  }

  @override
  void dispose() {
    productNameController.dispose();
    skuController.dispose();
    locationController.dispose();
    barcodeController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final firebaseStorageRef = FirebaseStorage.instance.ref();
    final productImage = firebaseStorageRef.child(skuController.text.trim().toUpperCase());
    final productsRef = ref.watch(RiverpodService.firebaseProductListProvider);
    return productsRef.when(
        data: (data) {
          List<ProductModel> productList = [];
          for (var snapshot in data.docs) {
            final product = ProductModel.fromMap(snapshot.data());
            productList.add(product);
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                leading: const BackToHomeScreen(),
                title: const Text(Titles.addProductScreenTitle),
              ),
              body: SingleChildScrollView(
                // *! all form should be connected to barcode value. If it matches a product on the database other
                // *! fields completed automatically.
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: productNameController,
                          validator: ((value) {
                            if (productList
                                .any((product) => product.productName.toUpperCase() == value!.toUpperCase())) {
                              return 'There is already this product name';
                            } else if (value!.isEmpty) {
                              return 'Enter a product name';
                            } else {
                              return null;
                            }
                          }),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Product Name',
                            hintText: 'Enter the product name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: skuController,
                          validator: ((value) {
                            if (productList.any((product) => product.sku == value!.toUpperCase())) {
                              return 'There is already this SKU';
                            } else if (value!.isEmpty) {
                              return 'Enter a SKU';
                            } else {
                              return null;
                            }
                          }),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'SKU',
                            hintText: 'Enter an SKU',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: locationController,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter a location';
                            } else {
                              return null;
                            }
                          }),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Location',
                            hintText: 'Enter the location',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: barcodeController,
                          validator: ((value) {
                            if (productList.any((product) => product.barcode == value)) {
                              return 'There is already this barcode';
                            } else if (value!.isEmpty) {
                              return 'Enter a barcode';
                            } else {
                              return null;
                            }
                          }),
                          decoration: InputDecoration(
                            suffix: IconButton(
                                onPressed: () async {
                                  try {
                                    final barcode = await FlutterBarcodeScanner.scanBarcode(
                                      "#ff6666",
                                      'Cancel',
                                      false,
                                      ScanMode.BARCODE,
                                    );
                                    setState(() {
                                      barcodeController.text = barcode;
                                    });
                                  } on PlatformException catch (e) {
                                    print(e);
                                  }
                                  if (!mounted) return;
                                },
                                icon: const Icon(Icons.qr_code_scanner_rounded)),
                            border: const OutlineInputBorder(),
                            labelText: 'Barcode',
                            hintText: 'Barcode',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: quantityController,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter a quantity';
                            } else {
                              return null;
                            }
                          }),
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
                          onPressed: () {
                            void takeImage() async {
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

                            if (_formKey.currentState!.validate()) {
                              takeImage();
                            }
                          },
                          child: const Icon(Icons.photo_camera),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          final photoURL = await productImage.getDownloadURL();
                          final userName = ref
                              .read(RiverpodService.firebaseAuthProvider)
                              .firebaseAuth
                              .currentUser!
                              .displayName as String;
                          ProductModel product = ProductModel(
                            userName: userName,
                            productName: productNameController.text,
                            sku: skuController.text,
                            location: locationController.text,
                            barcode: barcodeController.text,
                            quantity: int.parse(quantityController.text),
                            photo1: photoURL,
                            photo2: null,
                            photo3: null,
                          );
                          void submitForm() {
                            try {
                              ref
                                  .read(RiverpodService.firebaseDatabaseProvider)
                                  .addProduct(product)
                                  .then((value) => clearTextFields());
                            } catch (e) {
                              print('Error: $e');
                            }
                          }

                          if (_formKey.currentState!.validate()) {
                            submitForm();
                          }
                        },
                        child: const Text(
                          'AddProduct',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        error: ((error, stackTrace) => const Text('error')),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
