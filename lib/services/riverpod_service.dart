import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/routes.dart';
import 'package:well_organized/services/firebase_auth_service.dart';
import 'package:well_organized/services/firebase_database_service.dart';

class RiverpodService {
  static final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) => FirebaseAuthService());
  static final authStateProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChange);
  static final firebaseDatabaseProvider = Provider<FirebaseDatabaseService>((ref) => FirebaseDatabaseService());
  static final routeProvider = Provider<GoRouter>((ref) {
    final authState = ref.watch(authStateProvider);
    final router = Routes();
    return GoRouter(
      initialLocation: authState.value == null ? '/login' : '/home',
      debugLogDiagnostics: true,
      refreshListenable: router,
      routes: router.routes,
    );
  });
}
