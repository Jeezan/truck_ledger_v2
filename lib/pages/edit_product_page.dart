import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class EditProductPage extends StatefulWidget {
  final ProductData product;
  final VoidCallback onDelete;
  final Future<bool> Function(ProductData) onUpdate;
  final GlobalKey<FormState> formKey;

  const EditProductPage({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onUpdate,
    required this.formKey,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _productNameController;
  late TextEditingController _productPriceController;
  late String _transactionType;

  @override
  void initState() {
    _productNameController = TextEditingController(
      text: widget.product.productName,
    );
    _productPriceController = TextEditingController(
      text: widget.product.unitPrice.toString(),
    );
    _transactionType = widget.product.transactionType;

    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets().customAppBar(
        text: widget.product.productName,
        actions: [
          IconButton(
            onPressed: () {
              _onDeleteIconPress(context);
            },
            icon: Icon(
              Icons.delete_forever_sharp,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Product Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
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
                controller: _productPriceController,
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
                initialValue: _transactionType,
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
                    _transactionType = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: AppColors.elevatedButtonBackgroundColor,
                    foregroundColor: AppColors.elevatedButtonForegroundColor,
                    elevation: 1,
                  ),
                  onPressed: () async {
                    if (widget.formKey.currentState!.validate()) {
                      final newName = _productNameController.text;
                      final newPrice = double.parse(
                        _productPriceController.text,
                      );
                      final newType = _transactionType;

                      await widget.onUpdate(
                        ProductData(
                          id: widget.product.id,
                          productName: newName,
                          unitPrice: newPrice,
                          transactionType: newType,
                        ),
                      );

                      final changes = <String>[];

                      if (widget.product.productName != newName) {
                        changes.add(
                          'Name: "${widget.product.productName}" >> "$newName"',
                        );
                      }

                      if (widget.product.unitPrice != newPrice) {
                        changes.add(
                          'Price: LKR ${widget.product.unitPrice} >> LKR $newPrice',
                        );
                      }

                      if (widget.product.transactionType != newType) {
                        changes.add(
                          'Type: ${widget.product.transactionType} >> $newType',
                        );
                      }

                      if (!mounted) return;

                      Navigator.pop(context);

                      CustomWidgets().customSnackBar(
                        context,
                        changes.isEmpty
                            ? 'No changes were made.'
                            : 'Updated: ${changes.join(", ")}',
                        Colors.deepPurple,
                      );
                    }
                  },
                  child: const Text(
                    'Update Changes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeleteIconPress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),

        content: Text(
          'Are you sure you want to delete ${widget.product.productName}?',
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete();
              Navigator.pop(context);
              Navigator.pop(context);

              CustomWidgets().customSnackBar(
                context,
                '${widget.product.productName} removed from List',
                Colors.red.shade400,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
