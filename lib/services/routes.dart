//! I quit to use GoRouter for now. BottomNavigationBar works instead.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/add_product.dart';
import 'package:well_organized/screens/home_screen.dart';
import 'package:well_organized/screens/login_screen.dart';
import 'package:well_organized/screens/product_list.dart';
import 'package:well_organized/services/firebase_auth_service.dart';

class Routes extends ChangeNotifier {
  List<GoRoute> get routes => [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: 'addProduct',
          path: '/addProduct',
          builder: (context, state) => const AddProduct(),
        ),
        GoRoute(
          name: 'productList',
          path: '/productList',
          builder: (context, state) => const ProductList(),
        ),
      ];
}

// final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) => FirebaseAuthService());
// final authStateProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChange);
// final routeProvider = Provider<GoRouter>((ref) {
//   final authState = ref.watch(authStateProvider);
//   final router = Routes();
//   return GoRouter(
//     initialLocation: authState.value == null ? '/login' : '/',
//     debugLogDiagnostics: true,
//     refreshListenable: router,
//     routes: router.routes,
//   );
// });
