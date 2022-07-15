import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/product_model.dart';

class FirebaseDatabaseService {
  static final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  static final DatabaseReference ref = _firebaseDatabase.ref();

  Future<void> addProduct(ProductModel product) async {
    final productsRef = ref.child('Products/${product.sku.toUpperCase()}');
    await productsRef.set(product.toMap());
  }

  static Future<void> addUser(User userName) async {
    final userRef = ref.child('Users/${userName.displayName}');
    await userRef.set({
      'Username': userName.displayName,
      'email': userName.email,
    });
  }
}
