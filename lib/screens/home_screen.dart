import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/services/riverpod_service.dart';

import '../widgets/create_elevated_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
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
            const CreateElevatedButton(null),
            ElevatedButton(onPressed: () {}, child: const Text('PlaceHolderText')),
            ElevatedButton(onPressed: () {}, child: const Text('PlaceHolderText')),
            ElevatedButton(onPressed: () {}, child: const Text('PlaceHolderText')),
          ],
        ),
      ),
    );
  }
}
