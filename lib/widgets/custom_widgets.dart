import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';

class CustomWidgets {
  void customSnackBar(
    BuildContext context,
    String text,
    Color backgroundColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        content: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: backgroundColor,
      ),
    );
  }

  // App Bar

  PreferredSizeWidget customAppBar(String text) {
    return AppBar(title: Text(text, style: AppTextStyles.appBarFontStyle));
  }

  // Show Future features Dialog

  void showFutureFeaturesUpdate(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          'The $title functionality and features will be available in the next update',
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Custom Floating Action Button

  Widget customFloatingActionButton({
    required void Function()? onPressed,
    required IconData icon,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: 1,
      shape: CircleBorder(),
      child: Icon(icon),
    );
  }

  // Widget to show when no products are available to show in the Product Master page

  Widget emptyProductsDisplay({
    required VoidCallback onPressed,
    required String text,
    required Icon icon,
  }) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.inventory_2_outlined, size: 80, color: Colors.black26),
        const SizedBox(height: 16),
        const Text(
          'No products available',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade200,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );

  // Custom Cart Card

  // void customCartCard( bool isPositive, ) {
  //   Card(
  //     elevation: 1,
  //     margin: const EdgeInsets.symmetric(vertical: 4),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: ListTile(
  //       leading: CircleAvatar(
  //         backgroundColor: isPositive
  //             ? Colors.green.shade100
  //             : Colors.red.shade100,
  //         child: Icon(
  //           isPositive
  //               ? Icons.arrow_downward_rounded
  //               : Icons.arrow_upward_rounded,
  //           color: isPositive ? Colors.green.shade700 : Colors.red.shade700,
  //           size: 18,
  //         ),
  //       ),
  //       title: Text(
  //         item.productName,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 15,
  //         ),
  //       ),
  //       subtitle: Text(
  //         '$typeLabel • Qty: ${item.quantity} x LKR ${item.unitPrice.toStringAsFixed(2)}',
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: Colors.grey.shade600,
  //         ),
  //       ),
  //       trailing: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             '${isPositive ? '+' : '-'} LKR ${(item.quantity * item.unitPrice).toStringAsFixed(2)}',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 14,
  //               color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
  //             ),
  //           ),
  //           IconButton(
  //             icon: const Icon(
  //               Icons.delete_outline_rounded,
  //               color: Colors.redAccent,
  //               size: 20,
  //             ),
  //             onPressed: () {
  //               setState(() {
  //                 _cart.removeAt(index);
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //  Widget _bottomSummaryCard() {
  //   if (_selectedCustomer == null) {
  //     return const SizedBox();
  //   }
  //   return StreamBuilder<CustomerData?>(
  //     stream: db.watchCustomer(_selectedCustomer!),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData || snapshot.data == null) {
  //         return const SizedBox();
  //       }
  //       final customer = snapshot.data!;
  //       final previousBalance = customer.customerBalance;
  //       final finalBalance = previousBalance + cartTotal;

  //       return Container(
  //         padding: const EdgeInsets.all(18),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: const BorderRadius.vertical(
  //             top: Radius.circular(20),
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.shade300,
  //               blurRadius: 10,
  //               offset: const Offset(0, -4),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Previous Balance:',
  //                   style: TextStyle(fontSize: 13, color: Colors.grey),
  //                 ),
  //                 Text(
  //                   'LKR ${previousBalance.toStringAsFixed(2)}',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 13,
  //                     color: previousBalance >= 0
  //                         ? Colors.green.shade700
  //                         : Colors.red.shade700,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 4),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Net Counter Change:',
  //                   style: TextStyle(fontSize: 13, color: Colors.grey),
  //                 ),
  //                 Text(
  //                   'LKR ${cartTotal.toStringAsFixed(2)}',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 13,
  //                     color: cartTotal >= 0
  //                         ? Colors.green.shade700
  //                         : Colors.red.shade700,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const Padding(
  //               padding: EdgeInsets.symmetric(vertical: 8),
  //               child: Divider(height: 1),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Final Balance:',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //                 Text(
  //                   'LKR ${finalBalance.toStringAsFixed(2)}',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 15,
  //                     color: finalBalance >= 0
  //                         ? Colors.green.shade700
  //                         : Colors.red.shade700,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 12),
  //             SizedBox(
  //               width: double.infinity,
  //               child: _customButton(
  //                 text: 'Complete Transaction',
  //                 width: double.infinity,
  //                 onTap: () {
  //                   _showCheckoutDialog(finalBalance, customer);
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
