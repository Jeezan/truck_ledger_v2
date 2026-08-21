import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:truck_ledger_v2/database/app_database.dart';

class FirebaseSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sync a single customer record
  Future<void> syncCustomer(CustomerData customer) async {
    await _firestore.collection('customers').doc(customer.id.toString()).set({
      'id': customer.id,
      'customerName': customer.customerName,
      'customerPhoneNumber': customer.customerPhoneNumber,
      'customerAddress': customer.customerAddress,
      'currentBalance': customer.currentBalance,
      'syncedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Delete a customer from Firestore
  Future<void> deleteCustomerFromCloud(int customerId) async {
    await _firestore
        .collection('customers')
        .doc(customerId.toString())
        .delete();
  }

  // Sync a single transaction
  Future<void> syncTransaction(TransactionMasterData tx) async {
    await _firestore.collection('transactions').doc(tx.id.toString()).set({
      'id': tx.id,
      'customerId': tx.customerId,
      'totalAmount': tx.totalAmount,
      'createdAt': tx.createdAt.toIso8601String(),
      'syncedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Delete a transaction from Firestore
  Future<void> deleteTransactionFromCloud(int transactionId) async {
    await _firestore
        .collection('transactions')
        .doc(transactionId.toString())
        .delete();
  }

  // Sync a single transaction item
  Future<void> syncTransactionItem(TransactionItemData transactionItem) async {
    await _firestore
        .collection('transactionItems')
        .doc(transactionItem.id.toString())
        .set({
          'id': transactionItem.id,
          'transactionId': transactionItem.transactionId,
          'productId': transactionItem.productId,
          'productName': transactionItem.productName,
          'unitPrice': transactionItem.unitPrice,
          'quantity': transactionItem.quantity,
          'type': transactionItem.type,
          'syncedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  Future<void> deleteTransactionItemFromCloud(int transactionId) async {
    await _firestore
        .collection('transactionItems')
        .doc(transactionId.toString())
        .delete();
  }

  // Sync a single product
  Future<void> syncProduct(ProductData product) async {
    await _firestore.collection('products').doc(product.id.toString()).set({
      'id': product.id,
      'productName': product.productName,
      'unitPrice': product.unitPrice,
      'transactionType': product.transactionType,
      'syncedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Delete a product from Firestore
  Future<void> deleteProductFromCloud(int productId) async {
    await _firestore.collection('products').doc(productId.toString()).delete();
  }

  // Sync a single inventory item
  Future<void> syncInventory(InventoryData inventory) async {
    await _firestore.collection('inventory').doc(inventory.id.toString()).set({
      'id': inventory.id,
      'productId': inventory.productId,
      'customName': inventory.customName,
      'customPrice': inventory.customPrice,
      'quantity': inventory.quantity,
      'transactionType': inventory.tranctionType,
      'syncedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Delete an inventory item from Firestore
  Future<void> deleteInventoryFromCloud(int inventoryId) async {
    await _firestore
        .collection('inventory')
        .doc(inventoryId.toString())
        .delete();
  }

  Future<void> syncCustomerLedger(CustomerLedgerData customerLedger) async {
    await _firestore
        .collection('customerLedger')
        .doc(customerLedger.id.toString())
        .set({
          'id': customerLedger.id,
          'customerId': customerLedger.customerId,
          'productId': customerLedger.productId,
          'transactionType': customerLedger.transactionType,
          'quantity': customerLedger.quantity,
          'unitPrice': customerLedger.unitPrice,
          'creditAmount': customerLedger.creditAmount,
          'debitAmount': customerLedger.debitAmount,
          'paymentAmount': customerLedger.paymentAmount,
          'balance': customerLedger.balance,
          'createdAt': customerLedger.createdAt.toIso8601String(),
          'syncedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  // Sync all local tables to Firestore concurrently
  Future<void> syncAllData(AppDatabase database) async {
    final customers = await database.select(database.customer).get();
    final transactions = await database
        .select(database.transactionMaster)
        .get();
    final transactionItems = await database
        .select(database.transactionItem)
        .get();
    final products = await database.select(database.product).get();
    final inventories = await database.select(database.inventory).get();
    final customerLedgerEntries = await database
        .select(database.customerLedger)
        .get();

    await Future.wait([
      ...customers.map(syncCustomer),
      ...transactions.map(syncTransaction),
      ...transactionItems.map(syncTransactionItem),
      ...products.map(syncProduct),
      ...inventories.map(syncInventory),
      ...customerLedgerEntries.map(syncCustomerLedger),
    ]);
  }

  // Pull remote data from Firestore into Drift
  Future<void> pullAllData(AppDatabase db) async {
    // 1. Pull Customers
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

    // 2. Pull Products
    final productSnap = await _firestore.collection('products').get();
    for (var doc in productSnap.docs) {
      final data = doc.data();
      await db
          .into(db.product)
          .insertOnConflictUpdate(
            ProductCompanion(
              id: Value(data['id']),
              productName: Value(data['productName'] ?? ''),
              unitPrice: Value((data['unitPrice'] ?? 0.0).toDouble()),
              transactionType: Value(data['transactionType'] ?? ''),
            ),
          );
    }

    // 3. Pull Inventory
    final inventorySnap = await _firestore.collection('inventory').get();
    for (var doc in inventorySnap.docs) {
      final data = doc.data();
      await db
          .into(db.inventory)
          .insertOnConflictUpdate(
            InventoryCompanion(
              id: Value(data['id']),
              productId: Value(data['productId']),
              customName: Value(data['customName']),
              customPrice: Value(
                data['customPrice'] != null
                    ? (data['customPrice'] as num).toDouble()
                    : null,
              ),
              quantity: Value(data['quantity'] ?? 0),
              tranctionType: Value(data['transactionType'] ?? ''),
            ),
          );
    }

    // 4. Pull Transactions
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
              createdAt: Value(
                data['createdAt'] != null
                    ? DateTime.parse(data['createdAt'])
                    : DateTime.now(),
              ),
            ),
          );
    }

    // 5. Pull Transaction Items
    final txItemSnap = await _firestore.collection('transactionItems').get();
    for (var doc in txItemSnap.docs) {
      final data = doc.data();
      await db
          .into(db.transactionItem)
          .insertOnConflictUpdate(
            TransactionItemCompanion(
              id: Value(data['id']),
              transactionId: Value(data['transactionId']),
              productId: Value(data['productId']),
              productName: Value(data['productName'] ?? ''),
              unitPrice: Value((data['unitPrice'] ?? 0.0).toDouble()),
              quantity: Value(data['quantity'] ?? 0),
              type: Value(data['type'] ?? ''),
            ),
          );
    }
  }
}
