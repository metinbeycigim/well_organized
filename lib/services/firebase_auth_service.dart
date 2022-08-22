import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/services/firebase_database_service.dart';

class FirebaseAuthService {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
      print(e.message);
    }
  }

  Future<void> signUp(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => value.user!.updateDisplayName(email.split('@')[0]),
          );
      final userName = firebaseAuth.currentUser as User;
      await FirebaseDatabaseService().addUser(userName);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> signOut() async => await firebaseAuth.signOut();
  static final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) => FirebaseAuthService());
  static final authStateProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChange);
}
