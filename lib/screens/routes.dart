import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/add_product.dart';
import 'package:well_organized/screens/home_screen.dart';
import 'package:well_organized/screens/login_screen.dart';

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
      ];
}
