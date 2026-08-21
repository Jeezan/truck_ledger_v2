import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/pages/counter_page.dart';
import 'package:truck_ledger_v2/pages/customer/customer_page.dart';
import 'package:truck_ledger_v2/pages/inventory_page.dart';
import 'package:truck_ledger_v2/pages/menu_page.dart';
import 'package:truck_ledger_v2/services/firebase_sync_service.dart';
// Ensure this points to your actual FirebaseSyncService file
// import 'package:truck_ledger_v2/services/firebase_sync_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Added WidgetsBindingObserver to listen for app open/close events
class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CounterPage(),
    const InventoryPage(),
    const CustomerPage(),
    const MenuPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Register the observer when the app starts
    WidgetsBinding.instance.addObserver(this);

    // Run an initial sync immediately when the app opens
    _runBackgroundSync();
  }

  @override
  void dispose() {
    // Clean up the observer when the app is destroyed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This method fires automatically whenever the app's state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came back to the foreground (Opened) -> Pull & Push
      _runBackgroundSync();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      // App went to the background (Closed/Minimised) -> Push only to save bandwidth
      _runBackgroundSync(pushOnly: true);
    }
  }

  // Silent background sync method
  Future<void> _runBackgroundSync({bool pushOnly = false}) async {
    try {
      final syncService = FirebaseSyncService();
      if (pushOnly) {
        await syncService.syncAllData(appDatabase);
      } else {
        await syncService.syncAllData(appDatabase);
        await syncService.pullAllData(appDatabase);
      }
      debugPrint('Background sync successful');
    } catch (e) {
      // We fail silently here so it doesn't interrupt the user experience
      debugPrint('Background sync failed: $e');
    }
  }

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
