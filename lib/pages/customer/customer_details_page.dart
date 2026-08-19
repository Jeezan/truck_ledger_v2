import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/pages/customer/edit_customer_page.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';
import 'package:truck_ledger_v2/widgets/customer_widgets.dart';

class CustomerDetailsPage extends StatelessWidget {
  final CustomerData customer;
  CustomerDetailsPage({super.key, required this.customer});

  final database = appDatabase;
  final NumberFormat _currencyFormat = NumberFormat('#,##0.00', 'en_US');

  // Password confirmation dialog
  void _showDeletePasswordDialog(BuildContext context, int transactionId) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // Set your desired password here or fetch it from secure storage
    const String secretPassword = '7334';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Transaction'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to delete this transaction? Enter admin password to confirm.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: 'Admin Password',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value != secretPassword) {
                      return 'Incorrect password';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(dialogContext);
                  await database.deleteTransactionMaster(transactionId);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transaction deleted successfully'),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

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

                Expanded(
                  child: StreamBuilder<List<TransactionMasterData>>(
                    stream: database.watchCustomerTransactions(
                      customerId: currentCustomer.id,
                    ),
                    builder: (context, snapshot) {
                      final transactions = snapshot.data ?? [];

                      if (transactions.isEmpty) {
                        return const Center(
                          child: Text('No previous transactions recorded yet.'),
                        );
                      }

                      return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          final formattedDate = DateFormat(
                            'EEE, dd MMM yyyy - hh:mm a',
                          ).format(tx.createdAt);

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: const Icon(
                                Icons.receipt_long,
                                color: Colors.teal,
                              ),
                              title: Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  const Text('Net Change: '),
                                  Text(
                                    'LKR. ${_currencyFormat.format(tx.totalAmount)}',
                                    style: TextStyle(
                                      color: tx.totalAmount >= 0
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                CustomerWidgets().showTransactionDetailsModal(
                                  context,
                                  tx.id,
                                  formattedDate,
                                );
                              },

                              onLongPress: () {
                                _showDeletePasswordDialog(context, tx.id);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
