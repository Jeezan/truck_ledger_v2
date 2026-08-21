import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/database/app_database.dart';
import 'package:truck_ledger_v2/widgets/custom_widgets.dart';

class FirebaseSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sync or update a single customer record in Firestore
  Future<void> syncCustomer(CustomerData customer, BuildContext context) async {
    try {
      await _firestore.collection('customers').doc(customer.id.toString()).set({
        'id': customer.id,
        'name': customer.customerName,
        'phone': customer.customerPhoneNumber,
        'address': customer.customerAddress,
        'currentBalance': customer.currentBalance,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      CustomWidgets().customSnackBar(
        context,
        'Error in customer data sync: $e',
        Colors.red,
      );
    }
  }

  Future<void> syncTransaction(TransactionMasterData tx) async {
    try {
      await _firestore
          .collection('transactionMaster')
          .doc(tx.id.toString())
          .set({
            'id': tx.id,
            'customerId': tx.customerId,
            'totalAmount': tx.totalAmount,
            'createdAt': tx.createdAt.toIso8601String(),
            'syncedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
    } catch (e) {}
  }

  Future<void> syncTransactionItems(
    TransactionItemData transactionItem,
    BuildContext context,
  ) async {
    try {
      await _firestore
          .collection('transactionItem')
          .doc(transactionItem.id.toString())
          .set({
            'id': transactionItem.id,
            'transactionId': transactionItem.transactionId,
            'productId': transactionItem.productId,
            'productName': transactionItem.productName,
            'unitPrice': transactionItem.unitPrice,
            'quantity': transactionItem.quantity,
            'type': transactionItem.type,
          }, SetOptions(merge: true));
    } catch (e) {
      CustomWidgets().customSnackBar(
        context,
        'Error in Transaction Item data sync: $e',
        Colors.red,
      );
    }
  }

  Future<void> syncProduct(
    ProductData product,
    BuildContext context,
  ) async {
    try {
      await _firestore.collection('product').doc(product.id.toString()).set({
        'id': product.id,
        'productName': product.productName,
        'unitPrice': product.unitPrice,
        'transactionType': product.transactionType,
      }, SetOptions(merge: true));
    } catch (e) {
      CustomWidgets().customSnackBar(
        context,
        'Error in Product Item data sync: $e',
        Colors.red,
      );
    }
  }

  Future<void> syncInventory(
    InventoryData inventory,
    BuildContext context,
  ) async {
    try {
      await _firestore.collection('invetory').doc(inventory.id.toString()).set({
        'id': inventory.id,
        'ProductId': inventory.productId,
        'customName': inventory.customName,
        'customPrice': inventory.customPrice,
        'quantity': inventory.quantity,
        'transactionType': inventory.tranctionType,
      }, SetOptions(merge: true));
    } catch (e) {
      CustomWidgets().customSnackBar(
        context,
        'Error in Inventory Item data sync: $e',
        Colors.red,
      );
    }
  }

  Future<void> syncAllData(AppDatabase database, BuildContext context) async {
    final customers = await database.select(database.customer).get();
    for (var customer in customers) {
      await syncCustomer(customer, context);
    }

    final transactions = await database
        .select(database.transactionMaster)
        .get();
    for (var tx in transactions) {
      await syncTransaction(tx);
    }

    final transactionItems = await database
        .select(database.transactionItem)
        .get();
    for (var transactionItem in transactionItems) {
      await syncTransactionItems(transactionItem, context);
    }

    final products = await database.select(database.product).get();
    for (var product in products) {
      await syncProduct(product, context);
    }

    final inventories = await database.select(database.inventory).get();
    for (var inventory in inventories) {
      await syncInventory(inventory, context);
    }
  }

  Future<void> pushAllData(AppDatabase db) async {
    final customers = await db.select(db.customer).get();
    for (var c in customers) {
      await _firestore.collection('customers').doc(c.id.toString()).set({
        'id': c.id,
        'customerName': c.customerName,
        'customerPhoneNumber': c.customerPhoneNumber,
        'customerAddress': c.customerAddress,
        'currentBalance': c.currentBalance,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    final transactions = await db.select(db.transactionMaster).get();
    for (var tx in transactions) {
      await _firestore.collection('transactions').doc(tx.id.toString()).set({
        'id': tx.id,
        'customerId': tx.customerId,
        'totalAmount': tx.totalAmount,
        'createdAt': tx.createdAt.toIso8601String(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> pullAllData(AppDatabase db) async {
    // Download Customers
    final customerSnap = await _firestore.collection('customers').get();
    for (var doc in customerSnap.docs) {
      final data = doc.data();
      await db
          .into(db.customer)
          .insertOnConflictUpdate(
            CustomerCompanion(
              id: Value(data['id']),
              customerName: Value(data['customerName'] ?? ''),
              customerPhoneNumber: Value(data['customerPhoneNumber'] ?? ''),
              customerAddress: Value(data['customerAddress'] ?? ''),
              currentBalance: Value((data['currentBalance'] ?? 0.0).toDouble()),
            ),
          );
    }

    // Download Transactions
    final txSnap = await _firestore.collection('transactions').get();
    for (var doc in txSnap.docs) {
      final data = doc.data();
      await db
          .into(db.transactionMaster)
          .insertOnConflictUpdate(
            TransactionMasterCompanion(
              id: Value(data['id']),
              customerId: Value(data['customerId']),
              totalAmount: Value((data['totalAmount'] ?? 0.0).toDouble()),
              createdAt: Value(DateTime.parse(data['createdAt'])),
            ),
          );
    }
  }
}
