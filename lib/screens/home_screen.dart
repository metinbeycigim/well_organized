import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_organized/screens/add_product.dart';
import 'package:well_organized/screens/ebay_products.dart';
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
    const EbayProducts(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Product'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Product List'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Ebay Products'),
            ],
            currentIndex: _selectedIndex,
            onTap: _changeIndex,
          ),
        ),
      ),
      body: _screens.elementAt(_selectedIndex),
    );
  }
}
