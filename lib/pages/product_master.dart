import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/pages/edit_product_page.dart';
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
  String _selectedAction = 'sale';
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
      appBar: CustomWidgets().customAppBar(text: 'PRODUCT MASTER'),

      floatingActionButton: CustomWidgets().customFloatingActionButton(
        onPressed: () {
          _floatingActionPress();
        },
        icon: Icons.add,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),

        child: StreamBuilder(
          stream: database.watchAllProducts(),
          builder: (context, snapshot) {
            final products = snapshot.data ?? [];

            if (products.isEmpty) {
              return CustomWidgets().emptyProductsDisplay(
                onPressed: () {
                  _floatingActionPress();
                },
                text: 'Add Product',
                icon: Icon(Icons.add),
              );
            }

            return ListView(
              padding: EdgeInsets.all(16),

              children: [
                const Text(
                  'Give to Farms (Sales)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                StreamBuilder<List<ProductData>>(
                  stream: database.watchSaleProducts(),
                  builder: (context, snapshot) {
                    final products = snapshot.data ?? [];

                    if (products.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            'No Products Added. Press + to add',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return _productCard(context, product);
                      },
                    );
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

                StreamBuilder<List<ProductData>>(
                  stream: database.watchPurchaseProducts(),
                  builder: (context, snapshot) {
                    final products = snapshot.data ?? [];

                    if (products.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            'No Products Added. Press + to add',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return _productCard(context, product);
                      },
                    );
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

          Navigator.pop(context);
          CustomWidgets().customSnackBar(
            context,
            '\'${_productNameController.text}\' added to \'$_selectedAction\' category',
            AppColors.primaryColor,
          );

          _productNameController.clear();
          _productPriceController.clear();
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
