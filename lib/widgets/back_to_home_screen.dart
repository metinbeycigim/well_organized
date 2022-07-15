import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackToHomeScreen extends StatelessWidget {
  const BackToHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_sharp),
      onPressed: () => context.go('/'),
    );
  }
}
