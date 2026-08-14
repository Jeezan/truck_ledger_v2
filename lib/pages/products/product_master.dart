import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/pages/products/edit_product_page.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';
import 'package:truck_ledger_v2/widgets/product_master_widgets.dart';

class ProductMaster extends StatefulWidget {
  const ProductMaster({super.key});

  @override
  State<ProductMaster> createState() => _ProductMasterState();
}

class _ProductMasterState extends State<ProductMaster> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  // 1. Initialized using the enum instead of the 'sale' magic string
  String _selectedAction = TransactionType.sale.value;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyEdit = GlobalKey<FormState>();
  final database = appDatabase;

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'PRODUCT MASTER'),

      floatingActionButton: CustomWidgets().customFloatingActionButton(
        onPressed: _floatingActionPress,
        icon: Icons.add,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        // 2. We only watch the database ONCE now
        child: StreamBuilder<List<ProductData>>(
          stream: database.watchAllProducts(),
          builder: (context, snapshot) {
            // Show a loading indicator while the stream connects
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final allProducts = snapshot.data ?? [];

            if (allProducts.isEmpty) {
              return CustomWidgets().emptyProductsDisplay(
                onPressed: _floatingActionPress,
                text: 'Add Product',
                icon: const Icon(Icons.add),
              );
            }

            // 3. Filter the lists in memory using the enum!
            final salesProducts = allProducts
                .where((p) => p.transactionType == TransactionType.sale.value)
                .toList();

            final purchaseProducts = allProducts
                .where(
                  (p) => p.transactionType == TransactionType.purchase.value,
                )
                .toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Give to Farms (Sales)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Render Sales
                if (salesProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Center(
                      child: Text(
                        'No Products Added. Press + to add',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: salesProducts.length,
                    itemBuilder: (context, index) {
                      return _productCard(context, salesProducts[index]);
                    },
                  ),

                const SizedBox(height: 20),

                const Text(
                  'Get from Farms (Purchases)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Render Purchases
                if (purchaseProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        'No Products Added. Press + to add',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: purchaseProducts.length,
                    itemBuilder: (context, index) {
                      return _productCard(context, purchaseProducts[index]);
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _floatingActionPress() {
    ProductMasterWidget().onFloatingButtonPressed(
      context: context,
      titleText: 'Add Product',
      buttonText: 'Add Product',
      productNameController: _productNameController,
      productPriceController: _productPriceController,
      selectedAction: _selectedAction,
      formKey: _formKey,
      onActionChanged: (String value) => _selectedAction = value,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await database.addProduct(
            productName: _productNameController.text,
            unitPrice: double.parse(_productPriceController.text),
            transactionType: _selectedAction,
          );

          // 4. Check if widget is mounted before using context after an async gap
          if (!mounted) return;

          Navigator.pop(context);

          CustomWidgets().customSnackBar(
            context,
            '\'${_productNameController.text}\' added to \'$_selectedAction\' category',
            AppColors.primaryColor,
          );

          _productNameController.clear();
          _productPriceController.clear();

          // Reset action to default Enum value for the next time the modal opens
          setState(() {
            _selectedAction = TransactionType.sale.value;
          });
        }
      },
    );
  }

  Widget _productCard(BuildContext context, ProductData product) {
    return ProductMasterWidget().productCard(
      context: context,
      product: product,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditProductPage(
              formKey: _formKeyEdit,
              product: product,
              onDelete: () async {
                await database.deleteProduct(product.id);
              },
              onUpdate: (updatedProduct) async =>
                  await database.updateProduct(updatedProduct),
            ),
          ),
        );
      },
    );
  }
}
