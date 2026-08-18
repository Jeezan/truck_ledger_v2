import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/counter_widgets.dart';

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
  final List<CartItem> _cart = [];

  final database = appDatabase;

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
          CounterWidgets().customDropDown(
            selectedCustomer: _selectedCustomer,
            onChanged: (value) {
              setState(() {
                _selectedCustomer = value;
              });
            },
          ),

          if (_selectedCustomer != null) ...[
            const SizedBox(height: 5),
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
                    cartList: _cart,
                    onCartUpdated: () {
                      setState(() {});
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Active Items in Counter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    '${_cart.length} entries',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: _cart.isEmpty
                ? const Center(
                    child: Column(
                      children: [
                        Text(
                          'No items in counter cart yet.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Icon(
                          Icons.shopping_cart_checkout_sharp,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ],
                    ),
                  )
                : CounterWidgets().CounterCard(
                    cart: _cart,
                    onCartUpdated: () {
                      setState(() {});
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
