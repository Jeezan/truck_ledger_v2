import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/pages/product_master.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets().customAppBar(text: 'MENU'),

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
                      Icons.cloud_upload_outlined,
                      color: Colors.blue,
                    ),

                    title: const Text('Backup to Cloud'),
                    subtitle: const Text('Sync offline data to Firebase'),

                    trailing: const Icon(Icons.chevron_right_sharp),

                    // TODO: ON-TAP FUNCTION FOR BACKUP TO CLOUD
                    onTap: () {
                      CustomWidgets().showFutureFeaturesUpdate(
                        context,
                        'Cloud Backup',
                      );
                    },
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
                subtitle: Text('1.0.0 (Offline Mode)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
