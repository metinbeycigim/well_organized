import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';

class FirebaseDatabaseService {
  FirebaseFirestore get firebaseDatabase => FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get firebaseProductRef => firebaseDatabase.collection('Products');
  CollectionReference<Map<String, dynamic>> get firebaseUserRef => firebaseDatabase.collection('Users');

  Future<void> addProduct(ProductModel product) async {
    final productsRef = firebaseProductRef.doc(product.sku.toUpperCase());
    await productsRef.set(product.toMap());
  }

  Future<void> updateQuantity(ProductModel product, int addedQuantity, String? photo2, String? photo3) async {
    final productsRef = firebaseProductRef.doc(product.sku.toUpperCase());
    await productsRef.update({'quantity': product.quantity + addedQuantity, 'photo2': photo2, 'photo3': photo3});
  }

  Future<void> addUser(User userName) async {
    final userRef = firebaseUserRef.doc(userName.displayName);
    await userRef.set({
      'Username': userName.displayName,
      'email': userName.email,
    });
  }
}
