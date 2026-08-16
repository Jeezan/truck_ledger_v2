import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/counter_widgets.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _paymentAmountController =
      TextEditingController();

  String _transactionType = TransactionType.sale.value;
  String _paymentType = PaymentType.cashOut.value;

  int? _selectedCustomer;
  int? _selectedProduct;

  final database = AppDatabase();

  @override
  void dispose() {
    _priceController.dispose();
    _qtyController.dispose();
    _paymentController.dispose();
    _paymentAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.counterScaffoldBackgroundColor,
      appBar: CounterWidgets().counterAppBar(
        title: 'COUNTER',
        backgroundColor: AppColors.counterAppbarBackgroundColor,
      ),
      body: Column(
        children: [
          CounterWidgets().customDropDown(selectedCustomer: _selectedCustomer),

          SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CounterWidgets().customButton(
              width: double.infinity,
              text: 'Add Products',
              icon: Icons.add_circle_outline_sharp,
              onTap: () {
                CounterWidgets().onAddProductButtonPressed(
                  context: context,
                  priceController: _priceController,
                  transactionType: _transactionType,
                  qtyController: _qtyController,
                );
              },
            ),
          ),

          SizedBox(height: 5),

          Row(
            children: [
              Text(
                'Active Items in Counter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),

              //  TODo: Add the cart length
              Text(
                'Cart Length Entries',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
