import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/routes.dart';
import 'package:well_organized/services/firebase_service.dart';

class RiverpodService {
  static final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseService.firebaseAuth);
  static final firebaseDatabaseProvider = Provider<FirebaseDatabase>((ref) => FirebaseService.firebaseDatabase);
  static final routeProvider = Provider<GoRouter>((ref) {
    final router = Routes(ref);
    return GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      refreshListenable: router,
      routes: router.routes,
    );
  });
}
