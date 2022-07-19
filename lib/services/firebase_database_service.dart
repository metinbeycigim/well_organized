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

  Future<void> addUser(User userName) async {
    final userRef = firebaseUserRef.doc(userName.displayName);
    await userRef.set({
      'Username': userName.displayName,
      'email': userName.email,
    });
  }
}
