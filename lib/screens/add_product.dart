import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/constants/titles.dart';
import 'package:well_organized/widgets/add_image_button.dart';
import 'package:well_organized/widgets/back_to_home_screen.dart';

import '../models/product_model.dart';
import '../services/riverpod_service.dart';

extension Path on String {
  String pathToUrl(int index) => '$this/$this-${index.toString()}';
}

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
    final productsRef = ref.watch(RiverpodService.firebaseProductListProvider);
    final imageRef = ref.watch(RiverpodService.firebaseStorageProvider);

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
              appBar: AppBar(
                leading: const BackToHomeScreen(),
                title: const Text(Titles.addProductScreenTitle),
              ),
              body: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                //! form validations should be detailed. They get validated easily right now.
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: productNameController,
                          validator: ((value) {
                            if (value!.isEmpty) {
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
                          onChanged: (value) {
                            for (var product in productList) {
                              if (product.sku == value.toUpperCase()) {
                                productNameController.text = product.productName;
                                barcodeController.text = product.barcode;
                                locationController.text = product.location;
                              }
                            }
                          },
                          validator: ((value) {
                            if (value!.isEmpty) {
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
                          onChanged: (value) {
                            void clearSku = skuController.clear();
                            void clearLocation = locationController.clear();
                            void clearProductName = productNameController.clear();
                            for (var product in productList) {
                              if (product.barcode == value) {
                                productNameController.text = product.productName;
                                skuController.text = product.sku;
                                locationController.text = product.location;
                              } else {
                                clearLocation;
                                clearSku;
                                clearProductName;
                              }
                            }
                          },
                          validator: ((value) {
                            if (value!.isEmpty) {
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: quantityController,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter a quantity';
                            } else if (value.contains(RegExp('[A-Za-z]'))) {
                              return 'Enter just a number';
                            } else {
                              return null;
                            }
                          }),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Quantity',
                            hintText: 'Enter the quantity',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: AddImageButton(
                          formKey: _formKey,
                          imageRef: imageRef,
                          skuController: skuController,
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
                        //! photourl values should be dynamic.
                        onPressed: () async {
                          final path = skuController.text.trim().toUpperCase();
                          final itemCount = await imageRef.firebaseStorageRef
                              .child('Images/$path')
                              .listAll()
                              .then((value) => value.items.length);

                          String photoURL = itemCount >= 0
                              ? await imageRef.firebaseStorageRef
                                  .child('Images/$path/$path-${1.toString()}')
                                  .getDownloadURL()
                              : '';
                          String photoURL2 = itemCount >= 1
                              ? await imageRef.firebaseStorageRef
                                  .child('Images/$path/$path-${2.toString()}')
                                  .getDownloadURL()
                              : '';
                          String photoURL3 = itemCount >= 2
                              ? await imageRef.firebaseStorageRef
                                  .child('Images/$path/$path-${3.toString()}')
                                  .getDownloadURL()
                              : '';
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
                            photo2: photoURL2,
                            photo3: photoURL3,
                          );
                          //! if there are new photos they should be submit before add product button works.
                          if (_formKey.currentState!.validate()) {
                            try {
                              if (productList.any((element) =>
                                  element.sku == skuController.text || element.barcode == barcodeController.text)) {
                                ref
                                    .read(RiverpodService.firebaseDatabaseProvider)
                                    .updateQuantity(
                                        productList[productList.indexWhere((element) =>
                                            element.sku == skuController.text ||
                                            element.barcode == barcodeController.text)],
                                        int.parse(quantityController.text),
                                        photoURL2,
                                        photoURL3)
                                    .then((value) => clearTextFields());
                              } else {
                                ref
                                    .read(RiverpodService.firebaseDatabaseProvider)
                                    .addProduct(product)
                                    .then((value) => clearTextFields());
                              }
                            } catch (e) {
                              print('Error: $e');
                            }
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
