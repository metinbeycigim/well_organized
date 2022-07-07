import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();
}
