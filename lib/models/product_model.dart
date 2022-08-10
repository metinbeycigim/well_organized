import 'dart:convert';

class ProductModel {
  String userName;
  String productName;
  String sku;
  String location;
  String barcode;
  int quantity;
  String? photo1;
  String? photo2;
  String? photo3;
  ProductModel({
    required this.userName,
    required this.productName,
    required this.sku,
    required this.location,
    required this.barcode,
    required this.quantity,
    this.photo1,
    this.photo2,
    this.photo3,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'productName': productName,
      'sku': sku.toUpperCase(),
      'location': location.toUpperCase(),
      'barcode': barcode,
      'quantity': quantity,
      'photo1': photo1,
      'photo2': photo2,
      'photo3': photo3,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      userName: map['userName'] ?? '',
      productName: map['productName'] ?? '',
      sku: map['sku'] ?? '',
      location: map['location'] ?? '',
      barcode: map['barcode'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      photo1: map['photo1'] ?? '',
      photo2: map['photo2'] ?? '',
      photo3: map['photo3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
