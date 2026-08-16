import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class InventoryWidgets {
  final database = appDatabase;

  void onFloatingButtonPressed({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController itemQuantityController,
    required TextEditingController customItemNameController,
    required TextEditingController customItemPriceController,
    required TextEditingController customItemQuantityController,
    required Future<bool> Function(
      bool isCustom,
      int? selectedProduct,
      String txType,
    )
    onSave,
  }) {
    bool isCustomEntry = false;
    int? selectedMasterProduct;
    String selectedTxType = TransactionType.sale.value;

    showModalBottomSheet(
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add Inventory Stock',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: const Text('Select Product'),
                              selected: !isCustomEntry,
                              onSelected: (selected) =>
                                  setModalState(() => isCustomEntry = false),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ChoiceChip(
                              label: const Text('Custom Product'),
                              selected: isCustomEntry,
                              onSelected: (selected) =>
                                  setModalState(() => isCustomEntry = true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (!isCustomEntry) ...[
                        StreamBuilder<List<ProductData>>(
                          stream: database.watchAllProducts(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final products = snapshot.data ?? [];
                            return DropdownButtonFormField<int>(
                              initialValue: selectedMasterProduct,
                              validator: (value) => value == null
                                  ? 'Please select a product'
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Select Product',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: products.map((product) {
                                return DropdownMenuItem<int>(
                                  value: product.id,
                                  child: Text(
                                    '${product.productName} - LKR ${product.unitPrice}',
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) => setModalState(
                                () => selectedMasterProduct = value,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: itemQuantityController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (int.tryParse(value) == null ||
                                int.parse(value) <= 0) {
                              return 'Invalid quantity';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ] else ...[
                        TextFormField(
                          controller: customItemNameController,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Required'
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Custom Item Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: customItemPriceController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  if (double.tryParse(value) == null ||
                                      double.parse(value) < 0) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Price (LKR.)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixText: 'LKR.',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: customItemQuantityController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  if (int.tryParse(value) == null ||
                                      int.parse(value) <= 0) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: selectedTxType,
                          decoration: const InputDecoration(
                            labelText: 'Transaction Type',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: TransactionType.sale.value,
                              child: const Text('Give to Farms (Sales)'),
                            ),
                            DropdownMenuItem(
                              value: TransactionType.purchase.value,
                              child: const Text('Get from Farms (Purchases)'),
                            ),
                          ],
                          onChanged: (value) =>
                              setModalState(() => selectedTxType = value!),
                        ),
                      ],
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final bool isAdded = await onSave(
                                isCustomEntry,
                                selectedMasterProduct,
                                selectedTxType,
                              );
                              if (context.mounted && isAdded) {
                                CustomWidgets().customSnackBar(
                                  context,
                                  'Product added to List Successfully',
                                  AppColors.primaryColor,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor:
                                AppColors.elevatedButtonBackgroundColor,
                            foregroundColor:
                                AppColors.elevatedButtonForegroundColor,
                          ),
                          child: const Text('Add Inventory Stock'),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget customInventoryCard({
    required BuildContext context,
    required Key key,
    required int inventoryId,
    required String name,
    required double price,
    required int qty,
    required VoidCallback onEdit,
  }) {
    final totalValue = price * qty;

    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Inventory Item'),

              content: Text(
                'Are you sure you want to remove \'$name\' from inventory?',
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) async {
        await database.deleteInventory(inventoryId);

        if (context.mounted) {
          CustomWidgets().customSnackBar(
            context,
            'Customer \'$name\' removed from List',
            AppColors.secondaryColor,
          );
        }
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
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: LKR ${price.toStringAsFixed(2)} | Qty: $qty'),
              Text(
                'Total: LKR ${totalValue.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.green),
            onPressed: onEdit,
          ),
        ),
      ),
    );
  }

  Widget emptyInventoryDisplay({required VoidCallback onAddPressed}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.list_alt_sharp, size: 80, color: Colors.black26),
          const SizedBox(height: 16),
          const Text(
            'No Inventory added',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: const Text(
              'Add Inventory',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade200,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget totalInventoryValueCard() {
    final NumberFormat currencyFormatter = NumberFormat('#,##0.00');
    return StreamBuilder(
      stream: database.watchInventoryTotalValue(),
      builder: (context, asyncSnapshot) {
        final value = asyncSnapshot.data ?? 0;

        final formattedValue = currencyFormatter.format(
          value,
        );

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.green.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Inventory Valuation',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'LKR. $formattedValue',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showManageStockDialog({
    required BuildContext context,
    required int inventoryId,
    required String name,
    required int currentQty,
  }) async {
    final TextEditingController qtyController = TextEditingController();
    final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();

    String addValue = 'add';
    String subtractValue = 'subtract';
    String setValue = 'Set';

    String mode = addValue;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Manage Stock: $name'),

              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Current Stock: $currentQty',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15, width: 260),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChoiceChip(
                        label: const Text('Add (+)'),

                        selected: mode == addValue,
                        onSelected: (value) {
                          setState(
                            () {
                              mode = addValue;
                            },
                          );
                        },
                      ),

                      ChoiceChip(
                        label: const Text('Sub (-)'),

                        selected: mode == subtractValue,
                        onSelected: (value) {
                          setState(
                            () {
                              mode = subtractValue;
                            },
                          );
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Set (=)'),

                        selected: mode == setValue,
                        onSelected: (value) {
                          setState(
                            () {
                              mode = setValue;
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Form(
                    key: dialogFormKey,
                    child: TextFormField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: mode == addValue
                            ? 'Enter quantity to Add'
                            : mode == subtractValue
                            ? 'Enter quantity to Subtract'
                            : 'Enter the Stock Value',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a quantity';
                        }
                        final parsed = int.tryParse(value.trim());
                        if (parsed == null || parsed < 0) {
                          return 'Enter a valid positive number';
                        }
                        if (mode == subtractValue && parsed > currentQty) {
                          return 'Cannot subtract more than current stock ($currentQty)';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),

                TextButton(
                  onPressed: () async {
                    if (dialogFormKey.currentState!.validate()) {
                      final int? val = int.tryParse(qtyController.text);

                      final snackBarData = currentQty;
                      int newQty = currentQty;

                      if (mode == addValue) {
                        newQty += val!;
                      } else if (mode == subtractValue) {
                        newQty -= val!;
                      } else {
                        newQty = val!;
                      }

                      await database.updateInventoryQuantity(
                        id: inventoryId,
                        newQuantity: newQty,
                      );
                      if (context.mounted) {
                        CustomWidgets().customSnackBar(
                          context,
                          'Inventory Value of \'$name\' updated from $snackBarData >> $newQty',
                          Colors.deepPurple,
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    mode == addValue
                        ? 'Add (+)'
                        : mode == subtractValue
                        ? 'Sub (-)'
                        : 'Set (=)',
                    style: TextStyle(
                      color: mode != subtractValue
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showDuplicateDialog({
    required BuildContext context,
    required int inventoryId,
    required String productName,
    required int currentQty,
    required int qtyToAdd,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Item already in Inventory'),

          content: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color:
                    Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
              ),
              children: [
                TextSpan(
                  text: '\'$productName\' ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextSpan(
                  text:
                      'is already in your inventory with a stock of \'$currentQty\'. ',
                ),

                TextSpan(
                  text:
                      'Would you like to add \'$qtyToAdd\' to the existing quantity?',
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                final newQty = currentQty + qtyToAdd;
                await database.updateInventoryQuantity(
                  id: inventoryId,
                  newQuantity: newQty,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  CustomWidgets().customSnackBar(
                    context,
                    'Inventory Value of \'$productName\' updated from $currentQty >> $newQty',
                    Colors.deepPurple,
                  );
                }
              },
              child: const Text(
                'Yes, Update Stock',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
