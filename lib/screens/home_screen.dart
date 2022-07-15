import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/constants/titles.dart';
import 'package:well_organized/services/riverpod_service.dart';

import '../widgets/build_elevated_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Titles.homeScreenTitle),
        actions: [
          IconButton(
            onPressed: () async => await ref.read(RiverpodService.firebaseAuthProvider).signOut(),
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Sign Out',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/addProduct'),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 45),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
              child: const Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/productList'),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 45),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
              child: const Text('Product List'),
            ),
            const BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
            const BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
          ],
        ),
      ),
    );
  }
}
