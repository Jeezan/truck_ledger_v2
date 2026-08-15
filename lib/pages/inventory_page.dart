import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';
import 'package:truck_ledger_v2/widgets/inventory_widgets.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _customItemNameController =
      TextEditingController();
  final TextEditingController _customItemPriceController =
      TextEditingController();
  final TextEditingController _customItemQuantityController =
      TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final database = appDatabase;

  @override
  void dispose() {
    _customItemNameController.dispose();
    _customItemPriceController.dispose();
    _customItemQuantityController.dispose();
    _itemQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'INVENTORY STOCK'),

      floatingActionButton: FloatingActionButton(
        elevation: 1,
        shape: const CircleBorder(),
        onPressed: _openAddInventorySheet,
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InventoryWidgets().totalInventoryValueCard(),

          Expanded(
            child: StreamBuilder<List<InventoryItemWithProduct>>(
              stream: database.watchInventoryWithProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data ?? [];

                if (items.isEmpty) {
                  return InventoryWidgets().emptyInventoryDisplay(
                    onAddPressed: _openAddInventorySheet,
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isCustom = item.inventory.productId == null;

                    final name = isCustom
                        ? (item.inventory.customName ?? 'Unknown')
                        : (item.product?.productName ?? 'Unknown');
                    final price = isCustom
                        ? (item.inventory.customPrice ?? 0.0)
                        : (item.product?.unitPrice ?? 0.0);
                    final qty = item.inventory.quantity;

                    return InventoryWidgets().customInventoryCard(
                      context: context,
                      inventoryId: item.inventory.id,
                      name: name,
                      price: price,
                      qty: qty,
                      key: ValueKey(item.inventory.id),

                      onEdit: () {
                        InventoryWidgets().showManageStockDialog(
                          context: context,
                          inventoryId: item.inventory.id,
                          name: name,
                          currentQty: item.inventory.quantity,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openAddInventorySheet() {
    InventoryWidgets().onFloatingButtonPressed(
      context: context,
      formKey: formKey,
      itemQuantityController: _itemQuantityController,
      customItemNameController: _customItemNameController,
      customItemPriceController: _customItemPriceController,
      customItemQuantityController: _customItemQuantityController,
      onSave: _saveInventory,
    );
  }

  Future<void> _saveInventory(
    bool isCustom,
    int? selectedProduct,
    String customTxType,
  ) async {
    if (isCustom) {
      await database.addCustomInventory(
        productName: _customItemNameController.text,
        unitPrice: double.tryParse(_customItemPriceController.text) ?? 0.0,
        quantity: int.tryParse(_customItemQuantityController.text) ?? 1,
        transactionType: customTxType,
      );
    } else {
      if (selectedProduct != null) {
        final product = await (database.select(
          database.product,
        )..where((p) => p.id.equals(selectedProduct))).getSingle();

        await database.addInventory(
          productId: selectedProduct,
          quantity: int.tryParse(_itemQuantityController.text) ?? 1,
          transactionType: product.transactionType,
        );
      }
    }

    _customItemNameController.clear();
    _customItemPriceController.clear();
    _customItemQuantityController.clear();
    _itemQuantityController.clear();

    if (mounted) Navigator.pop(context);
  }
}
