import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';

class CustomerWidgets {
  void onFloatingButtonPressed({
    required BuildContext context,
    required String titleText,
    required String buttonText,
    required TextEditingController customerNameController,
    required TextEditingController customerPhoneNumberController,
    required TextEditingController customerAddressController,
    required VoidCallback onPressed,
    required GlobalKey<FormState> formKey,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                top: 20,
                right: 20,
              ),

              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add New Customer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: customerNameController,
                      decoration: const InputDecoration(
                        labelText: 'Customer Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_sharp),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter customer name';
                        }

                        if (value.trim().length < 2) {
                          return 'Customer name must be at least 2 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    TextFormField(
                      controller: customerPhoneNumberController,
                      keyboardType: TextInputType.phone,

                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_sharp),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter contact number';
                        }

                        // Allows numbers with optional +, spaces, hyphens and parentheses
                        final phoneRegex = RegExp(r'^\+?[0-9\s\-()]{7,15}$');

                        if (!phoneRegex.hasMatch(value.trim())) {
                          return 'Please enter a valid contact number';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: customerAddressController,
                      decoration: const InputDecoration(
                        labelText: 'Address (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on_sharp),
                      ),

                      validator: (value) {
                        // Optional field, so empty is valid
                        if (value != null && value.trim().isNotEmpty) {
                          if (value.trim().length < 5) {
                            return 'Please enter a valid address';
                          }
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onPressed,

                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor:
                              AppColors.elevatedButtonBackgroundColor,
                          foregroundColor:
                              AppColors.elevatedButtonForegroundColor,
                        ),
                        child: const Text('Add Customer to List'),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
