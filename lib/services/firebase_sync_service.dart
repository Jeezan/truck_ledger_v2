import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:truck_ledger_v2/database/app_database.dart';

class FirebaseSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sync or update a single customer record in Firestore
  Future<void> syncCustomer(CustomerData customer) async {
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
      // Cloud sync failed (e.g. offline) - app continues locally
    }
  }

  // Backup a completed transaction record
  Future<void> syncTransaction(TransactionMasterData tx) async {
    try {
      await _firestore.collection('transactions').doc(tx.id.toString()).set({
        'id': tx.id,
        'customerId': tx.customerId,
        'totalAmount': tx.totalAmount,
        'createdAt': tx.createdAt.toIso8601String(),
        'syncedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      // Handles error silently for local-first functionality
    }
  }

  // Backup all local Drift database data to Firestore at once
  Future<void> syncAllData(AppDatabase database) async {
    final customers = await database.select(database.customer).get();
    for (var customer in customers) {
      await syncCustomer(customer);
    }

    final transactions = await database
        .select(database.transactionMaster)
        .get();
    for (var tx in transactions) {
      await syncTransaction(tx);
    }
  }

  // 📤 1. UPLOAD (Push Local Drift DB to Firebase)
  Future<void> pushAllData(AppDatabase db) async {
    // Sync Customers
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

    // Sync Transaction Masters
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

  // 📥 2. DOWNLOAD (Pull Firebase to Local Drift DB)
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
