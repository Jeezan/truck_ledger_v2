import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/pages/products/product_master.dart';
import 'package:truck_ledger_v2/services/firebase_sync_service.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _isSyncing = false;

  Future<void> _handleMultiDeviceSync() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      final syncService = FirebaseSyncService();

      await syncService.syncAllData(appDatabase);

      await syncService.pullAllData(appDatabase);

      if (mounted) {
        CustomWidgets().customSnackBar(
          context,
          'Multi-device sync completed successfully!',
          Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        CustomWidgets().customSnackBar(
          context,
          'Sync failed: ${e.toString()}',
          Colors.red,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'MENU'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                'Business Setup',
                style: AppTextStyles.menuHeadingFontStyle,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              elevation: 1,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.list_alt_sharp,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text('Product Master Price List'),
                    subtitle: const Text('Set Default Prices'),
                    trailing: const Icon(Icons.chevron_right_sharp),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductMaster(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 50, endIndent: 50),
                  ListTile(
                    leading: const Icon(
                      Icons.local_shipping_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text('Truck Route Management'),
                    subtitle: const Text('Organize your daily farm stops'),
                    trailing: const Icon(Icons.chevron_right_sharp),
                    // TODO: ON-TAP FUNCTION FOR DAILY TRUCK ROUTE
                    onTap: () {
                      CustomWidgets().showFutureFeaturesUpdate(
                        context,
                        'Truck Route',
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                'Data & Sync',
                style: AppTextStyles.menuHeadingFontStyle,
              ),
            ),
            Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.cloud_sync_outlined,
                      color: Colors.blue,
                    ),
                    title: const Text('Sync Across Devices'),
                    subtitle: const Text('Push & Pull data to Cloud'),
                    trailing: _isSyncing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.chevron_right_sharp),
                    onTap: _isSyncing ? null : _handleMultiDeviceSync,
                  ),
                  const Divider(height: 1, indent: 50, endIndent: 50),
                  ListTile(
                    leading: const Icon(
                      Icons.ios_share_sharp,
                      color: Colors.orange,
                    ),
                    title: const Text('Export Data'),
                    subtitle: const Text('Export records to Excel/PDF'),
                    onTap: () {
                      CustomWidgets().showFutureFeaturesUpdate(
                        context,
                        'Data Export',
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 50, endIndent: 50),
                  ListTile(
                    leading: const Icon(
                      Icons.save_alt_sharp,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text('Import Data'),
                    subtitle: const Text('Export Data from other sources'),
                    trailing: const Icon(Icons.chevron_right_sharp),
                    // TODO: ON-TAP FUNCTION FOR EXPORT DATA
                    onTap: () {
                      CustomWidgets().showFutureFeaturesUpdate(
                        context,
                        'Data Import',
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text('System', style: AppTextStyles.menuHeadingFontStyle),
            ),
            const Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: Icon(Icons.info_outlined),
                title: Text('App Version'),
                subtitle: Text('2.0.0 (Cloud-Sync Ready)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
