import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/constants/app_text_styles.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class EditCustomerPage extends StatefulWidget {
  final CustomerData customerData;
  final VoidCallback onDelete;

  const EditCustomerPage({
    super.key,
    required this.customerData,
    required this.onDelete,
  });

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  late TextEditingController _customerNameController;
  late TextEditingController _customerPhoneController;
  late TextEditingController _customerAddressController;

  final database = appDatabase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _customerNameController = TextEditingController(
      text: widget.customerData.customerName,
    );
    _customerPhoneController = TextEditingController(
      text: widget.customerData.customerPhoneNumber,
    );
    _customerAddressController = TextEditingController(
      text: widget.customerData.customerAddress,
    );
    super.initState();
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.customerData.customerName,
          style: AppTextStyles.appBarFontStyle,
        ),

        actions: [
          IconButton(
            onPressed: () {
              CustomWidgets().onDeleteIconPress(
                context: context,
                title: 'Delete Customer',
                content:
                    'Are you sure you want to delete customer \'${widget.customerData.customerName}\' permanantly?',
                onPressed: () {
                  database.deleteCustomer(widget.customerData.id);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  CustomWidgets().customSnackBar(
                    context,
                    'Customer \'${widget.customerData.customerName}\' removed from List',
                    AppColors.secondaryColor,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete_forever_sharp,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Customer Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),
              TextFormField(
                controller: _customerNameController,
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
                controller: _customerPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Customer Phone',
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
                controller: _customerAddressController,
                decoration: const InputDecoration(
                  labelText: 'Customer Address',
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final newName = _customerNameController.text;
                      final newPhone = _customerPhoneController.text;
                      final newAddress = _customerAddressController.text;

                      await database.updateCustomerInfo(
                        CustomerData(
                          id: widget.customerData.id,
                          customerName: newName,
                          customerPhoneNumber: newPhone,
                          customerAddress: newAddress,
                          currentBalance: widget.customerData.currentBalance,
                        ),
                      );
                      final changes = <String>[];

                      if (widget.customerData.customerName != newName) {
                        changes.add(
                          'Name: \'${widget.customerData.customerName}\' >> \'$newName\'',
                        );
                      }

                      if (widget.customerData.customerPhoneNumber != newPhone) {
                        changes.add(
                          'Phone Number: ${widget.customerData.customerPhoneNumber} >>  $newPhone',
                        );
                      }

                      if (widget.customerData.customerAddress != newAddress) {
                        changes.add(
                          'Address: ${widget.customerData.customerAddress} >> $newAddress',
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

                      _customerNameController.clear();
                      _customerAddressController.clear();
                      _customerPhoneController.clear();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: AppColors.elevatedButtonBackgroundColor,
                    foregroundColor: AppColors.elevatedButtonForegroundColor,
                  ),

                  child: const Text('Update Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
