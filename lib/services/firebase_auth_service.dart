import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  late final context;
  // static final firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  Future<void> signIn(String email, String password, String displayName, BuildContext context) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) =>value.user!.updateDisplayName(displayName) );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
      print(e.message);
    }
  }

  Future<void> signOut() async => await firebaseAuth.signOut();
}
