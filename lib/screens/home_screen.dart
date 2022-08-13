import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/screens/add_product.dart';
import 'package:well_organized/screens/product_list.dart';
import 'package:well_organized/screens/settings.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    const AddProduct(),
    const ProductList(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Product'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Product List'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _changeIndex,
        selectedIconTheme: const IconThemeData(size: 40),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 15,
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
      body: _screens.elementAt(_selectedIndex),
    );
  }
}
