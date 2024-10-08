import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/services/firebase_auth_service.dart';
import 'package:well_organized/services/firebase_database_service.dart';
import 'package:well_organized/services/firebase_storage_service.dart';
import 'package:well_organized/widgets/add_image_button.dart';
import 'package:well_organized/widgets/add_space.dart';

import '../models/app_product_model.dart';

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
    setState(() {});
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
    final productsRef = ref.watch(FirebaseDatabaseService.firebaseProductListProvider);
    final ValueNotifier<String> buttonState = ValueNotifier('Add Product');

    return productsRef.when(
        data: (data) {
          List<AppProductModel> productList = [];
          for (var snapshot in data.docs) {
            final product = AppProductModel.fromMap(snapshot.data());
            productList.add(product);
          }

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Add Product'),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                //! form validations should be detailed. They get validated easily right now.
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
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
                          textCapitalization: TextCapitalization.characters,
                          controller: skuController,
                          onChanged: (value) {
                            for (var product in productList) {
                              if (product.sku == value.toUpperCase()) {
                                productNameController.text = product.productName;
                                barcodeController.text = product.barcode;
                                locationController.text = product.location;
                              }
                            }
                            productList.any((element) => element.sku == value.toUpperCase())
                                ? buttonState.value = 'Update Product'
                                : buttonState.value = 'Add Product';
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
                          textCapitalization: TextCapitalization.characters,
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
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: barcodeController,
                          onChanged: (value) {
                            setState(() {
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
                              productList.any((element) => element.barcode == value.toUpperCase())
                                  ? buttonState.value = 'Update Product'
                                  : buttonState.value = 'Add Product';
                            });
                          },
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter a barcode';
                            }
                            return null;
                          }),
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: const Icon(Icons.qr_code_scanner_rounded),
                              onTap: () async {
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
                            ),
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
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: quantityController,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter a quantity';
                            } else {
                              return null;
                            }
                          }),
                          decoration: InputDecoration(
                            suffix: (productList
                                    .where((element) => element.barcode == barcodeController.text)
                                    .isNotEmpty)
                                ? Text(
                                    '${productList.where((element) => element.barcode == barcodeController.text).first.quantity} pc(s) at location')
                                : const Text(''),
                            border: const OutlineInputBorder(),
                            labelText: 'Quantity',
                            hintText: 'Enter the quantity',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: AddImageButton(
                            formKey: _formKey,
                            imageRef: FirebaseStorageService(),
                            skuController: skuController,
                          )),
                      verticalSpace(20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          final path = skuController.text.trim().toUpperCase();
                          final itemCount = await FirebaseStorageService()
                              .firebaseStorageRef
                              .child('Images/$path')
                              .listAll()
                              .then((value) => value.items.length);

                          Future<String> getPhotoUrl(int photoCount) async {
                            final photoUrl = await FirebaseStorageService()
                                .firebaseStorageRef
                                .child('Images/$path/$path-${photoCount.toString()}')
                                .getDownloadURL();

                            return photoUrl;
                          }

                          final userName =
                              FirebaseAuthService().firebaseAuthInstance.currentUser!.displayName as String;

                          AppProductModel product = AppProductModel(
                            userName: userName,
                            productName: productNameController.text,
                            sku: skuController.text,
                            location: locationController.text,
                            barcode: barcodeController.text,
                            quantity: (quantityController.text != '') ? int.parse(quantityController.text) : 0,
                            photo1: itemCount >= 1 ? await getPhotoUrl(1) : '',
                            photo2: itemCount >= 2 ? await getPhotoUrl(2) : '',
                            photo3: itemCount >= 3 ? await getPhotoUrl(3) : '',
                          );

                          if (_formKey.currentState!.validate()) {
                            try {
                              if (productList.any((element) =>
                                  element.sku == skuController.text || element.barcode == barcodeController.text)) {
                                FirebaseDatabaseService()
                                    .updateQuantity(
                                      productList[productList.indexWhere((element) =>
                                          element.sku == skuController.text ||
                                          element.barcode == barcodeController.text)],
                                      int.parse(quantityController.text),
                                      product.photo1,
                                      product.photo2,
                                      product.photo3,
                                    )
                                    .then((value) => clearTextFields());
                              } else {
                                FirebaseDatabaseService().addProduct(product).then((value) => clearTextFields());
                              }
                            } catch (e) {
                              print('Error: $e');
                            }
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: buttonState,
                          builder: (_, String value, __) {
                            return Text(value, style: const TextStyle(color: Colors.white, fontSize: 25));
                          },
                        ),
                      ),
                      verticalSpace(20),
                      ElevatedButton(
                        onPressed: () => context.push('/qrCode'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text('QR Code', style: TextStyle(color: Colors.white, fontSize: 25)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        error: ((error, stackTrace) => const Center(child: Text('error'))),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
