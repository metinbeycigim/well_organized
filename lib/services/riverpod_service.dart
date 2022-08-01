import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/routes.dart';
import 'package:well_organized/services/firebase_auth_service.dart';
import 'package:well_organized/services/firebase_database_service.dart';
import 'package:well_organized/services/firebase_storage.dart';

class RiverpodService {
  static final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) => FirebaseAuthService());
  static final firebaseDatabaseProvider = Provider<FirebaseDatabaseService>((ref) => FirebaseDatabaseService());
  static final firebaseStorageProvider = Provider<FirebaseStorageService>((ref) => FirebaseStorageService());
  static final firebaseProductListProvider = StreamProvider.autoDispose(
    (ref) => FirebaseDatabaseService().firebaseProductRef.snapshots(),
  );
  static final authStateProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChange);
  static final routeProvider = Provider<GoRouter>((ref) {
    final authState = ref.watch(authStateProvider);
    final router = Routes();
    return GoRouter(
      initialLocation: authState.value == null ? '/login' : '/',
      debugLogDiagnostics: true,
      refreshListenable: router,
      routes: router.routes,
    );
  });
}
