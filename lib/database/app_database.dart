import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Product extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text().withLength(max: 40)();
  RealColumn get unitPrice => real()();
  TextColumn get transactionType => text()();
}

class Customer extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerName => text().withLength(max: 60)();
  TextColumn get customerPhoneNumber => text().withLength(min: 10, max: 15)();
  TextColumn get customerAddress => text().nullable()();
  RealColumn get currentBalance => real().withDefault(const Constant(0.0))();
}

class Inventory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().nullable().references(Product, #id)();
  TextColumn get customName => text().nullable()();
  RealColumn get customPrice => real().nullable()();
  IntColumn get quantity => integer()();
  TextColumn get tranctionType => text()();
}

class TransactionMaster extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customer, #id)();
  RealColumn get totalAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TransactionItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer().references(TransactionMaster, #id)();
  // Nullable so deleting the master product won't delete historical records
  IntColumn get productId => integer().nullable().references(
    Product,
    #id,
    onDelete: KeyAction.setNull,
  )();
  // Historical snapshots (frozen at the moment of checkout)
  TextColumn get productName => text()();
  RealColumn get unitPrice => real()();
  IntColumn get quantity => integer()();
  TextColumn get type => text()();
}

class CustomerLedger extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customer, #id)();
  IntColumn get productId => integer().nullable().references(Product, #id)();
  TextColumn get transactionType => text()();
  IntColumn get quantity => integer().nullable()();
  RealColumn get unitPrice => real().nullable()();
  RealColumn get creditAmount => real().withDefault(const Constant(0))();
  RealColumn get debitAmount => real().withDefault(const Constant(0))();
  RealColumn get paymentAmount => real().withDefault(const Constant(0))();
  RealColumn get balance => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Product,
    Customer,
    Inventory,
    TransactionMaster,
    TransactionItem,
    CustomerLedger,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'ledger_database_II'));

  @override
  int get schemaVersion => 1;
}
