import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';

class CustomerWidgets {
  final NumberFormat _currencyFormat = NumberFormat('#,##0.00', 'en_US');
  void onFloatingButtonPressed({
    required BuildContext context,
    required String titleText,
    required String buttonText,
    required TextEditingController customerNameController,
    required TextEditingController customerPhoneNumberController,
    required TextEditingController customerAddressController,
    required VoidCallback onPressed,
    required GlobalKey<FormState> formKey,
  }) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                top: 20,
                right: 20,
              ),

              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add New Customer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: customerNameController,
                      decoration: const InputDecoration(
                        labelText: 'Customer Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_sharp),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter customer name';
                        }

                        if (value.trim().length < 2) {
                          return 'Customer name must be at least 2 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    TextFormField(
                      controller: customerPhoneNumberController,
                      keyboardType: TextInputType.phone,

                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_sharp),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter contact number';
                        }

                        // Allows numbers with optional +, spaces, hyphens and parentheses
                        final phoneRegex = RegExp(r'^\+?[0-9\s\-()]{7,15}$');

                        if (!phoneRegex.hasMatch(value.trim())) {
                          return 'Please enter a valid contact number';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: customerAddressController,
                      decoration: const InputDecoration(
                        labelText: 'Address (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on_sharp),
                      ),

                      validator: (value) {
                        // Optional field, so empty is valid
                        if (value != null && value.trim().isNotEmpty) {
                          if (value.trim().length < 5) {
                            return 'Please enter a valid address';
                          }
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onPressed,

                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor:
                              AppColors.elevatedButtonBackgroundColor,
                          foregroundColor:
                              AppColors.elevatedButtonForegroundColor,
                        ),
                        child: const Text('Add Customer to List'),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Empty Customer List
  Widget emptyCustomersDisplay({required VoidCallback onPressed}) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.person_sharp, size: 80, color: Colors.black26),
        const SizedBox(height: 16),
        const Text(
          'No Customers added',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: const Text(
            'Add Customers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade200,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );

  // Customer Card

  Widget customCustomerCard({
    required CustomerData customer,
    required VoidCallback onTap,
  }) {
    final double balance = customer.currentBalance;
    Color balanceColor = balance < 0
        ? Colors.red
        : (balance > 0 ? Colors.green : Colors.grey);
    String balanceStatus = balance < 0
        ? 'They owe you'
        : (balance > 0 ? 'You owe them' : 'Settled');
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.customerAvatarColor,
          child: Text(
            customer.customerName[0].toUpperCase(),
            style: TextStyle(color: AppColors.customerAvatarTextColor),
          ),
        ),
        title: Text(
          customer.customerName,
          style: AppTextStyles.customerCardTitleStyle,
        ),
        subtitle: Text(
          customer.customerPhoneNumber,
          style: AppTextStyles.customerCardSubtitleStyle,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'LKR. ${_currencyFormat.format(customer.currentBalance)}',
              style: AppTextStyles.customerBalanceMainStyle.copyWith(
                color: balanceColor,
              ),
            ),
            Text(
              balanceStatus,
              style: AppTextStyles.customerBalanceSubStyle.copyWith(
                color: balanceColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTransactionDetailsModal(
    BuildContext context,
    int transactionId,
    String dateText,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(modalContext).size.height * 0.75,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dateText,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(modalContext),
                  ),
                ],
              ),
              const Divider(height: 20),

              Expanded(
                child: StreamBuilder<List<TransactionItemData>>(
                  stream: appDatabase.watchTransactionItems(transactionId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = snapshot.data ?? [];

                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          'No items found for this transaction.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    final double totalTransactionAmount = items.fold(0.0, (
                      sum,
                      item,
                    ) {
                      final isCredit =
                          item.type == TransactionType.purchase.value ||
                          item.type == PaymentType.cashIn.value;
                      final itemTotal = item.quantity * item.unitPrice;
                      return isCredit ? sum + itemTotal : sum - itemTotal;
                    });

                    return SafeArea(
                      maintainBottomViewPadding: true,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final item = items[index];

                                final isCredit =
                                    item.type ==
                                        TransactionType.purchase.value ||
                                    item.type == PaymentType.cashIn.value;

                                final itemTotal =
                                    item.quantity * item.unitPrice;

                                return ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: isCredit
                                        ? Colors.green.shade50
                                        : Colors.red.shade50,
                                    child: Icon(
                                      isCredit
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: isCredit
                                          ? Colors.green
                                          : Colors.red,
                                      size: 18,
                                    ),
                                  ),
                                  title: Text(
                                    item.productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${item.quantity} x LKR ${_currencyFormat.format(item.unitPrice)}',
                                  ),
                                  trailing: Text(
                                    '${isCredit ? '+' : '-'} LKR ${_currencyFormat.format(itemTotal)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: isCredit
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const Divider(height: 20, thickness: 1.5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Net Total:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'LKR ${_currencyFormat.format(totalTransactionAmount.abs())}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: totalTransactionAmount >= 0
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
