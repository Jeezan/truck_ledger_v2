import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/constants/app_colors.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';
import 'package:truck_ledger_v2/widgets/cutomer_widgets.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final database = appDatabase;

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneNumberController.dispose();
    _customerAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets().customAppBar(text: 'CUSTOMER'),

      floatingActionButton: CustomWidgets().customFloatingActionButton(
        onPressed: () {
          _floatingActionButtonPress();
        },
        icon: Icons.person_add_alt_1_sharp,
      ),
    );
  }

  void _floatingActionButtonPress() {
    CutomerWidgets().onFloatingButtonPressed(
      context: context,
      titleText: 'Add New Customer',
      buttonText: 'Add Customer to List',
      customerNameController: _customerNameController,
      customerPhoneNumberController: _customerPhoneNumberController,
      customerAddressController: _customerAddressController,

      formKey: _formKey,

      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await database.addCustomer(
            customerName: _customerNameController.text,
            customerPhoneNumber: _customerPhoneNumberController.text,
            customerAddress: _customerAddressController.text,
          );

          CustomWidgets().customSnackBar(
            context,
            '\'${_customerNameController.text}\' added successfully',
            AppColors.primaryColor,
          );

          _customerNameController.clear();
          _customerAddressController.clear();
          _customerPhoneNumberController.clear();
          Navigator.pop(context);
        }
      },
    );
  }
}
