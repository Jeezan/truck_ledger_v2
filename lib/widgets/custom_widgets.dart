import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';

// App Bar

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;

  const CustomAppBar({super.key, required this.text, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text, style: AppTextStyles.appBarFontStyle),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

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
      shape: const CircleBorder(),
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
          label: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
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

  // Delete Dialog Box

  void onDeleteIconPress({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          content,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onPressed,

            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
