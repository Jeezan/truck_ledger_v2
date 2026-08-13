import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';

class ProductMasterWidget {
  void onFloatingButtonPressed({
    required BuildContext context,
    required String titleText,
    required String buttonText,
    required VoidCallback onPressed,
    required TextEditingController productNameController,
    required TextEditingController productPriceController,
    required String selectedAction,
    required ValueChanged<String> onActionChanged,

    required GlobalKey<FormState> formKey,
  }) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: productNameController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name (e.g. Layer Feed Pellets)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a product name';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    TextFormField(
                      controller: productPriceController,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        labelText: 'Default Price (LKR.)',
                        border: OutlineInputBorder(),
                        prefix: Text(
                          'LKR. ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a price';
                        }

                        final price = double.tryParse(value.trim());

                        if (price == null) {
                          return 'Please enter a valid price';
                        }

                        if (price <= 0) {
                          return 'Price must be greater than 0';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: selectedAction,
                      decoration: const InputDecoration(
                        labelText: 'Transaction Type',
                        border: OutlineInputBorder(),
                      ),

                      items: [
                        const DropdownMenuItem(
                          value: 'sale',
                          child: Text('Give to Farms (Sales)'),
                        ),

                        const DropdownMenuItem(
                          value: 'purchase',
                          child: Text('Get from Farms (Purchases)'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          onActionChanged(value!);
                        });
                      },
                    ),

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

                        child: Text(buttonText),
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

  Widget productCard({
    required BuildContext context,
    required ProductData product,
    required VoidCallback onTap,
  }) {
    final bool isGive = product.transactionType == 'sale';

    return Card(
      elevation: 2,

      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor: isGive
              ? AppColors.avatarTrueColor
              : AppColors.avatarFalseColor,

          child: Icon(
            isGive ? Icons.arrow_upward : Icons.arrow_downward,
            color: isGive
                ? AppColors.avatarTrueIconColor
                : AppColors.avatarFalseIconColor,
          ),
        ),

        title: Text(
          product.productName,
          style: AppTextStyles.productCardTitleStyle,
        ),

        subtitle: Text(
          isGive ? 'Type: Give to farm' : 'Type: Get from farm',
          style: TextStyle(
            color: isGive ? Colors.red.shade600 : Colors.green.shade600,
          ),
        ),

        trailing: Text(
          'LKR. ${product.unitPrice}',
          style: AppTextStyles.productCardTrailingStyle,
        ),
      ),
    );
  }
}
