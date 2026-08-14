import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/pages/counter_page.dart';
import 'package:truck_ledger_v2/pages/customer/customer_page.dart';
import 'package:truck_ledger_v2/pages/inventory_page.dart';
import 'package:truck_ledger_v2/pages/menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    CounterPage(),
    InventoryPage(),
    CustomerPage(),
    MenuPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.point_of_sale_sharp),
            label: 'Counter',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Customers',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu_sharp),
            label: 'Menu',
          ),
        ],
      ),

      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
