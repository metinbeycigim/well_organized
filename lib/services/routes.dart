import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/add_product.dart';
import 'package:well_organized/screens/home_screen.dart';
import 'package:well_organized/screens/login_screen.dart';
import 'package:well_organized/screens/product_list.dart';
import 'package:well_organized/screens/qr_code.dart';
import 'package:well_organized/screens/qr_print.dart';

@immutable
class Routes {
  const Routes._();
  static get instance => const Routes._();

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
        GoRoute(
          name: 'qrPrint',
          path: '/qrPrint',
          builder: (context, state) => QrPrint(state.extra as String),
        ),
        GoRoute(
          name: 'qrCode',
          path: '/qrCode',
          builder: (context, state) => const QrCode(),
        ),
      ];
}

// first approach before bottomnavigationbar was implemented and then it was changed with go_router 2.0

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
