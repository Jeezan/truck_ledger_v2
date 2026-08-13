import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class ProductMaster extends StatefulWidget {
  const ProductMaster({super.key});

  @override
  State<ProductMaster> createState() => _ProductMasterState();
}

class _ProductMasterState extends State<ProductMaster> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  String _selectedAction = 'sale';

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets().customAppBar('PRODUCT MASTER'),
    );
  }
}
