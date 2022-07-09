import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:well_organized/services/riverpod_service.dart';

import '../widgets/build_elevated_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) => setState(() {
        selectedIndex = index;
        switch (index) {
          case 0:
            return context.go('/');
          case 1:
            return context.go('/otherpage');
          case 2:
            return context.go('/anotherpage');
          default:
            return;
        }
      });

  @override
  Widget build(BuildContext context) {
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
          children: const [
            BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
            BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
            BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
            BuildElevatedButton('routeNamePlaceholder', 'buttonNamePlaceholder'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.building_2_fill),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bag),
            label: 'School',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
