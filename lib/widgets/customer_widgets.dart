import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';

class CustomerWidgets {
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
              '${customer.currentBalance}',
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
}
