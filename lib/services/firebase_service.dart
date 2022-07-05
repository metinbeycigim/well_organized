import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseDatabase = FirebaseDatabase.instance;
}
