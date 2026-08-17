import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';

class CounterWidgets {
  final database = AppDatabase();
  AppBar counterAppBar({
    required String title,
    required Color backgroundColor,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.appBarFontStyle.copyWith(
          color: AppColors.whiteColor,
        ),
      ),
      backgroundColor: backgroundColor,

      elevation: 0,

      centerTitle: true,
    );
  }

  Widget customDropDown({
    int? selectedCustomer,
  }) {
    return StreamBuilder(
      stream: database.watchAllCustomers(),
      builder: (context, snapshot) {
        final customers = snapshot.data ?? [];

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: AppColors.counterAppbarBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: DropdownButtonFormField(
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.whiteColor,
            ),

            initialValue: selectedCustomer,

            dropdownColor: AppColors.counterAppbarBackgroundColor,
            isExpanded: true,

            decoration: InputDecoration(
              labelText: 'Select Customer',
              labelStyle: TextStyle(color: Colors.teal.shade200),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),

                borderSide: BorderSide.none,
              ),

              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.15),
              isDense: true,
            ),
            items: customers.map(
              (customer) {
                return DropdownMenuItem<int>(
                  value: customer.id,
                  child: Text(
                    customer.customerName,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {},
          ),
        );
      },
    );
  }

  Widget customButton({
    required String text,
    required VoidCallback onTap,
    IconData? icon,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: width,
        decoration: BoxDecoration(
          color: AppColors.counterAppbarBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddProductButtonPressed({
    required BuildContext context,
    required TextEditingController priceController,
    required TextEditingController qtyController,
    required String transactionType,
    required List<CartItem> cartList,
    required VoidCallback onCartUpdated,
    int? selectedProduct,
  }) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.grey.shade100,
      useSafeArea: true,
      isScrollControlled: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    'Add Product to Counter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              transactionType = TransactionType.purchase.value;
                              selectedProduct = null;
                              priceController.clear();
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    transactionType ==
                                        TransactionType.purchase.value
                                    ? Colors.green.shade700
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Purchase (+)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      transactionType ==
                                          TransactionType.purchase.value
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              transactionType = TransactionType.sale.value;
                              selectedProduct = null;
                              priceController.clear();
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    transactionType ==
                                        TransactionType.sale.value
                                    ? Colors.red.shade700
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Sale (-)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      transactionType ==
                                          TransactionType.sale.value
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        transactionType == TransactionType.purchase.value
                            ? Icons.arrow_circle_down_rounded
                            : Icons.arrow_circle_up_rounded,
                        color: transactionType == TransactionType.purchase.value
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        transactionType == TransactionType.purchase.value
                            ? 'Add Purchase Entry (+)'
                            : 'Add Sale Entry (-)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color:
                              transactionType == TransactionType.purchase.value
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 130,
                        child: customButton(
                          text: 'Add Payment',
                          onTap: () {
                            Navigator.pop(context);
                            // onAddPaymentButtonPress();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  StreamBuilder<List<InventoryItemWithProduct>>(
                    stream: database.watchInventoryWithProductsByType(
                      transactionType,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final products = snapshot.data ?? [];

                      final GlobalKey<FormState> formKey =
                          GlobalKey<FormState>();

                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              initialValue: selectedProduct,

                              isExpanded: true,

                              decoration: InputDecoration(
                                labelText: 'Select Product from Stock',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),

                              items: products.map(
                                (item) {
                                  return DropdownMenuItem(
                                    value: item.inventory.id,
                                    child: Text(item.displayName),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    selectedProduct = value;

                                    final productSelected = products.firstWhere(
                                      (item) => item.inventory.id == value,
                                    );

                                    priceController.text = productSelected
                                        .displayPrice
                                        .toStringAsFixed(2);
                                  },
                                );
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a product';
                                }

                                return null;
                              },
                            ),

                            SizedBox(height: 10),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: priceController,
                                    keyboardType: TextInputType.number,

                                    decoration: InputDecoration(
                                      labelText: 'Unit Price (LKR.)',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter the unit price';
                                      }

                                      final price = double.tryParse(
                                        value.trim(),
                                      );

                                      if (price == null) {
                                        return 'Please enter a valid price';
                                      }

                                      if (price <= 0) {
                                        return 'Price must be greater than 0';
                                      }

                                      return null;
                                    },
                                  ),
                                ),

                                SizedBox(width: 12),

                                Expanded(
                                  child: TextFormField(
                                    controller: qtyController,
                                    keyboardType: TextInputType.number,

                                    decoration: InputDecoration(
                                      labelText: 'Quantity',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter the quantity';
                                      }

                                      final quantity = int.tryParse(
                                        value.trim(),
                                      );

                                      if (quantity == null) {
                                        return 'Please enter a valid quantity';
                                      }

                                      if (quantity <= 0) {
                                        return 'Quantity must be greater than 0';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),

                            SizedBox(
                              width: double.infinity,
                              child: customButton(
                                icon: Icons.add_circle_outline,
                                width: double.infinity,
                                text: 'Add to Counter List',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    final qty = int.tryParse(
                                      qtyController.text.trim(),
                                    );

                                    final price = double.tryParse(
                                      priceController.text.trim(),
                                    );

                                    final item = products.firstWhere(
                                      (p) => p.inventory.id == selectedProduct,
                                    );

                                    addToCart(
                                      cartList: cartList,
                                      item: item,
                                      price: price!,
                                      quantity: qty!,
                                      transactionType: transactionType,
                                    );
                                    onCartUpdated();
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showCustomDialog({required BuildContext context, required String text}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Input'),
        content: Text('The value you entered is invalid! $text'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget CounterCard({
    required List<CartItem> cart,

    required VoidCallback onCartUpdated,
  }) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),

      itemCount: cart.length,
      itemBuilder: (context, index) {
        final item = cart[index];

        final isPositive =
            item.type == TransactionType.purchase.value ||
            item.type == PaymentType.cashIn;

        String typeLabel;
        switch (item.type) {
          case 'purchase':
            typeLabel = 'Purchase';
            break;
          case 'cash_in':
            typeLabel = 'Cash In';
            break;
          case 'cash_out':
            typeLabel = 'Cash Out';
            break;
          default:
            typeLabel = 'Sale';
        }

        return Dismissible(
          key: ValueKey(cart[index].inventoryId),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cart.removeAt(index);
            onCartUpdated;
          },

          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.dismissibleWidgetColor,
              borderRadius: BorderRadius.circular(12),
            ),

            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Delete Inventory',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                SizedBox(width: 10),
                Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
          child: Card(
            elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isPositive
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                child: Icon(
                  isPositive
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: isPositive
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                  size: 18,
                ),
              ),

              title: Text(
                item.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                '$typeLabel • Qty: ${item.quantity} x LKR ${item.unitPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              trailing: Text(
                '${isPositive ? '+' : '-'} LKR ${(item.quantity * item.unitPrice).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isPositive
                      ? Colors.green.shade800
                      : Colors.red.shade800,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addToCart({
    required List<CartItem> cartList,
    required InventoryItemWithProduct item,
    required double price,
    required int quantity,
    required String transactionType,
    TextEditingController? qtyController,
    TextEditingController? priceController,
  }) {
    final existingIndex = cartList.indexWhere(
      (cartItem) =>
          cartItem.inventoryId == item.inventory.id &&
          cartItem.type == transactionType &&
          cartItem.unitPrice == price,
    );

    if (existingIndex != -1) {
      cartList[existingIndex].quantity += quantity;
    } else {
      cartList.add(
        CartItem(
          inventoryId: item.inventory.id,
          productId: item.inventory.productId,
          productName: item.displayName,
          unitPrice: price,
          quantity: quantity,
          type: transactionType,
        ),
      );
    }

    qtyController?.clear();
    priceController?.clear();
  }
}

class CartItem {
  final int inventoryId;
  final int? productId;
  final String productName;
  final double unitPrice;
  int quantity;
  final String type;

  CartItem({
    required this.inventoryId,
    this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.type,
  });

  double get total => unitPrice * quantity;
}
