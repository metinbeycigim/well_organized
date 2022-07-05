import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/screens/login_screen.dart';

class Routes extends ChangeNotifier {
  final Ref _ref;
  Routes(this._ref);



  List<GoRoute> get routes => [
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        )
      ];
}
