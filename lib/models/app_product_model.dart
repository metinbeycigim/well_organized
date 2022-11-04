import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class AppProductModel {
  final String userName;
  final String productName;
  final String sku;
  final String location;
  final String barcode;
  final int quantity;
  final String? photo1;
  final String? photo2;
  final String? photo3;
  const AppProductModel({
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

  factory AppProductModel.fromMap(Map<String, dynamic> map) {
    return AppProductModel(
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

  factory AppProductModel.fromJson(String source) => AppProductModel.fromMap(json.decode(source));
}
