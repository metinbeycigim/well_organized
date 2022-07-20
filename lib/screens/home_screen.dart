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
    final currentUser = ref.read(RiverpodService.firebaseAuthProvider).firebaseAuth.currentUser!.displayName;

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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/addProduct'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 50),
                      elevation: 5,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                  child: const Text('Add Product'),
                ),
                const SizedBox(
                  height: 50,
                ),
                if (currentUser == 'admin')
                  ElevatedButton(
                    onPressed: () => context.go('/productList'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 50),
                        elevation: 5,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                    child: const Text('Product List'),
                  ),
                if (currentUser == 'admin')
                  const SizedBox(
                    height: 50,
                  ),
                const BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
                const SizedBox(
                  height: 50,
                ),
                const BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
