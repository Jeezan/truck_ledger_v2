import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/services/firebase_sync_service.dart';

class CounterWidgets {
  final database = appDatabase;

  final NumberFormat _currencyFormat = NumberFormat('#,##0.00', 'en_US');

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
    required ValueChanged<int?> onChanged,
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
            onChanged: onChanged,
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade100,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
                  const Text(
                    'Add Product to Counter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(4),
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
                              qtyController.clear();
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
                              qtyController.clear();
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
                            onAddPaymentButtonPress(
                              context: context,
                              cart: cartList,
                              onCartUpdated: onCartUpdated,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<InventoryItemWithProduct>>(
                    stream: database.watchInventoryWithProductsByType(
                      transactionType,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final products = snapshot.data ?? [];

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
                                    // TextControllers must keep standard decimal string for double.tryParse
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
                            const SizedBox(height: 10),
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
                                const SizedBox(width: 12),
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
                            const SizedBox(height: 10),
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
                                    final item = products
                                        .cast<InventoryItemWithProduct?>()
                                        .firstWhere(
                                          (p) =>
                                              p?.inventory.id ==
                                              selectedProduct,
                                          orElse: () => null,
                                        );
                                    if (item == null) return;

                                    if (transactionType ==
                                        TransactionType.sale.value) {
                                      final availableStock =
                                          item.inventory.quantity;

                                      final existingInCartQty = cartList
                                          .where(
                                            (cartItem) =>
                                                cartItem.inventoryId ==
                                                    item.inventory.id &&
                                                cartItem.type ==
                                                    TransactionType.sale.value,
                                          )
                                          .fold<int>(
                                            0,
                                            (sum, cartItem) =>
                                                sum + cartItem.quantity,
                                          );

                                      final totalRequestedQty =
                                          existingInCartQty + qty!;

                                      if (totalRequestedQty > availableStock) {
                                        final remainingAllowed =
                                            availableStock - existingInCartQty;

                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            title: const Text(
                                              'Insufficient Stock',
                                            ),
                                            content: Text(
                                              existingInCartQty > 0
                                                  ? 'Total stock available: $availableStock.\n'
                                                        'You already have $existingInCartQty in your cart.\n'
                                                        'You can only add up to $remainingAllowed more unit(s).'
                                                  : 'You requested $qty units of "${item.displayName}", but only $availableStock units are available in stock.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                        return;
                                      }
                                    }

                                    addToCart(
                                      cartList: cartList,
                                      item: item,
                                      price: price!,
                                      quantity: qty!,
                                      transactionType: transactionType,
                                    );
                                    onCartUpdated();
                                    Navigator.pop(context);
                                    qtyController.clear();
                                    priceController.clear();
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

  void onAddPaymentButtonPress({
    required BuildContext context,
    required List<CartItem> cart,
    required VoidCallback onCartUpdated,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final paymentController = TextEditingController();
    final paymentAmountController = TextEditingController();
    String paymentType = PaymentType.cashIn.value;
    paymentController.text = paymentType == PaymentType.cashIn.value
        ? 'Cash Paid by Customer'
        : 'Cash Paid to Customer';

    showModalBottomSheet<CartItem>(
      backgroundColor: Colors.grey.shade100,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                    const Text(
                      'Add Payment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setModalState(() {
                                paymentType = PaymentType.cashIn.value;
                                paymentController.clear();
                                paymentController.text =
                                    'Cash Paid by Customer';
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: paymentType == PaymentType.cashIn.value
                                      ? Colors.green.shade700
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Cash In (+)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        paymentType == PaymentType.cashIn.value
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setModalState(() {
                                paymentType = PaymentType.cashOut.value;
                                paymentController.clear();
                                paymentController.text =
                                    'Cash Paid to Customer';
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      paymentType == PaymentType.cashOut.value
                                      ? Colors.red.shade700
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Cash Out (-)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        paymentType == PaymentType.cashOut.value
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
                          paymentType == PaymentType.cashIn.value
                              ? Icons.arrow_circle_down_rounded
                              : Icons.arrow_circle_up_rounded,
                          color: paymentType == PaymentType.cashIn.value
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          paymentType == PaymentType.cashIn.value
                              ? 'Cash Paid by Customer (+)'
                              : 'Cash Paid to Customer (-)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: paymentType == PaymentType.cashIn.value
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: paymentController,
                      decoration: InputDecoration(
                        labelText: 'Payment Note',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: paymentAmountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Payment Amount (LKR)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter payment amount';
                        }
                        final amount = double.tryParse(value.trim());
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid positive amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: customButton(
                        icon: Icons.add_circle_outline,
                        width: double.infinity,
                        text: 'Add to Counter List',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            final item = CartItem.payment(
                              paymentType: paymentType,
                              amount: double.parse(
                                paymentAmountController.text.trim(),
                              ),
                              note: paymentController.text,
                            );
                            cart.add(item);
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }

                            paymentAmountController.clear();
                            paymentController.clear();
                            onCartUpdated();
                          }
                        },
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

  Widget counterCard({
    required List<CartItem> cart,
    required VoidCallback onCartUpdated,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final item = cart[index];

        final isPositive =
            item.type == TransactionType.purchase.value ||
            item.type == PaymentType.cashIn.value;

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
          key: ValueKey(
            '${cart[index].inventoryId}_${cart[index].type}_$index',
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cart.removeAt(index);
            onCartUpdated();
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
                  'Delete Item from Cart',
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
            margin: const EdgeInsets.symmetric(vertical: 4),
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
                '$typeLabel • Qty: ${item.quantity} x LKR ${_currencyFormat.format(item.unitPrice)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              trailing: Text(
                '${isPositive ? '+' : '-'} LKR ${_currencyFormat.format(item.quantity * item.unitPrice)}',
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

  Widget bottomSummaryCard({
    required int? selectedCustomer,
    required List<CartItem> cart,
    required VoidCallback onCompleteCheckout,
  }) {
    if (selectedCustomer == null) {
      return const SizedBox();
    }
    return StreamBuilder<CustomerData?>(
      stream: database.watchCustomer(selectedCustomer),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox();
        }
        final customer = snapshot.data!;
        final previousBalance = customer.currentBalance;
        final netChange = cartTotal(cart: cart);
        final finalBalance = previousBalance + netChange;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Previous Balance:',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    'LKR ${_currencyFormat.format(previousBalance)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: previousBalance >= 0
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Net Counter Change:',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    'LKR ${_currencyFormat.format(netChange)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: netChange >= 0
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Final Balance:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'LKR ${_currencyFormat.format(finalBalance)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: finalBalance >= 0
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: customButton(
                  text: 'Complete Transaction',
                  width: double.infinity,
                  onTap: () {
                    showCheckoutDialog(
                      context: context,
                      totalFinalBalance: finalBalance,
                      customer: customer,
                      cart: cart,
                      selectedCustomer: selectedCustomer,
                      onCompleteCheckout: onCompleteCheckout,
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

  double cartTotal({required List<CartItem> cart}) {
    return cart.fold<double>(0.0, (sum, item) {
      final double itemTotal = item.unitPrice * item.quantity;

      if (item.type == TransactionType.purchase.value ||
          item.type == PaymentType.cashIn.value) {
        return sum + itemTotal;
      } else {
        return sum - itemTotal;
      }
    });
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

  void showCheckoutDialog({
    required BuildContext context,
    required double totalFinalBalance,
    required CustomerData customer,
    required List<CartItem> cart,
    required int? selectedCustomer,
    required VoidCallback onCompleteCheckout,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Confirm Transaction for ${customer.customerName}'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Previous Balance: '),
                    Text(
                      'LKR. ${_currencyFormat.format(customer.currentBalance)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: customer.currentBalance >= 0
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Cart Items Count: ${cart.length}'),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 6),
                const Text(
                  'Final Account Balance:',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  'LKR. ${_currencyFormat.format(totalFinalBalance)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: totalFinalBalance >= 0
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Are you sure you want to process this counter settlement and update inventory stocks?',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // 1. Save locally to Drift
                await database.completeCheckout(
                  customerId: selectedCustomer!,
                  netChange: cartTotal(cart: cart),
                  cartItems: cart,
                );

                onCompleteCheckout();
                Navigator.pop(context);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Transaction completed successfully!',
                      ),
                      backgroundColor: Colors.green.shade700,
                    ),
                  );
                }

                try {
                  FirebaseSyncService().syncAllData(database);
                } catch (e) {
                  debugPrint('Silent transaction sync failed: $e');
                }
              },
              child: const Text('Confirm & Save'),
            ),
          ],
        );
      },
    );
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

  factory CartItem.payment({
    required String paymentType,
    required double amount,
    String? note,
  }) {
    final isCashIn = paymentType == PaymentType.cashIn.value;
    final defaultNote = isCashIn
        ? 'Cash Paid by Customer'
        : 'Cash Paid to Customer';

    return CartItem(
      inventoryId: DateTime.now().microsecondsSinceEpoch,
      productId: null,
      productName: (note != null && note.trim().isNotEmpty)
          ? note.trim()
          : defaultNote,
      unitPrice: amount,
      quantity: 1,
      type: paymentType,
    );
  }

  bool get isPayment =>
      type == PaymentType.cashIn.value || type == PaymentType.cashOut.value;

  bool get isPositive =>
      type == TransactionType.purchase.value ||
      type == PaymentType.cashIn.value;
}
