import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/pages/customer/edit_customer_page.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class CustomerDetailsPage extends StatelessWidget {
  final CustomerData customer;
  CustomerDetailsPage({super.key, required this.customer});

  final database = appDatabase;

  // Formatter for comma-separated currency values with 2 decimal places
  final NumberFormat _currencyFormat = NumberFormat('#,##0.00', 'en_US');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.watchCustomer(customer.id),
      builder: (context, asyncSnapshot) {
        final currentCustomer = asyncSnapshot.data ?? customer;
        final double balance = currentCustomer.currentBalance;

        Color balanceColor = balance < 0
            ? Colors.red
            : (balance > 0 ? Colors.green : Colors.grey);
        String balanceStatus = balance < 0
            ? 'They owe you'
            : (balance > 0 ? 'You owe them' : 'Settled');

        return Scaffold(
          appBar: CustomAppBar(
            text: customer.customerName,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditCustomerPage(
                        customerData: customer,
                        onDelete: () {
                          database.deleteCustomer(customer.id);
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.mode_edit_sharp,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,

                  color: AppColors.customerDetailBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Balance',
                              style: AppTextStyles
                                  .customerDetailTitleCardTextStyle,
                            ),
                            Text(
                              'LKR. ${_currencyFormat.format(balance)}',
                              style: AppTextStyles
                                  .customerDetailSubtitleCardTextStyle
                                  .copyWith(color: balanceColor),
                            ),
                          ],
                        ),
                        Chip(
                          label: Text(
                            balanceStatus,
                            style: AppTextStyles.customerDetailChipTextStyle
                                .copyWith(color: balanceColor),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Contact Details
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: Text(customer.customerPhoneNumber),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
                if (customer.customerAddress != null &&
                    customer.customerAddress!.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.green),
                    title: Text(customer.customerAddress!),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),

                const Divider(height: 25),

                const Text(
                  'Transaction History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
