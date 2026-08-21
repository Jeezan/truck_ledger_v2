import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:truck_ledger_v2/constants/app_enums.dart';
import 'package:truck_ledger_v2/widgets/counter_widgets.dart';

part 'app_database.g.dart';

class Product extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text().withLength(max: 40)();
  RealColumn get unitPrice => real()();
  TextColumn get transactionType => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

class Customer extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerName => text().withLength(max: 60)();
  TextColumn get customerPhoneNumber => text().withLength(min: 10, max: 15)();
  TextColumn get customerAddress => text().nullable()();
  RealColumn get currentBalance => real().withDefault(const Constant(0.0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

class Inventory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().nullable().references(Product, #id)();
  TextColumn get customName => text().nullable()();
  RealColumn get customPrice => real().nullable()();
  IntColumn get quantity => integer()();
  TextColumn get tranctionType => text()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

class TransactionMaster extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customer, #id)();
  RealColumn get totalAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
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
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
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
  int get schemaVersion => 2;

  //  >>>>>>>>>>>>>>> Products Database Logics <<<<<<<<<<<<<<<<<<

  Future<int> addProduct({
    required String productName,
    required double unitPrice,
    required String transactionType,
  }) {
    return into(product).insert(
      ProductCompanion.insert(
        productName: productName,
        unitPrice: unitPrice,
        transactionType: transactionType,
      ),
    );
  }

  Future<int> deleteProduct(int id) {
    return (update(product)..where((p) => p.id.equals(id))).write(
      const ProductCompanion(isDeleted: Value(true)),
    );
  }

  Future<bool> updateProduct(ProductData item) {
    return update(product).replace(item);
  }

  Stream<List<ProductData>> watchAllProducts() {
    return (select(product)..where((p) => p.isDeleted.equals(false))).watch();
  }

  //  >>>>>>>>>>>>>>> End Of Products Database Logics <<<<<<<<<<<<<<<<<<
  //  >>>>>>>>>>>>>>> Customer Database Logics <<<<<<<<<<<<<<<<<<

  Future<int> addCustomer({
    required String customerName,
    required String customerPhoneNumber,
    String? customerAddress,
    double? currentBalance,
  }) {
    return into(customer).insert(
      CustomerCompanion.insert(
        customerName: customerName,
        customerPhoneNumber: customerPhoneNumber,
        customerAddress: Value(customerAddress),
      ),
    );
  }

  Future<CustomerData?> getCustomerById(int id) {
    return (select(customer)
          ..where((c) => c.id.equals(id) & c.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  Stream<List<CustomerData>> watchAllCustomers() {
    return (select(customer)..where((c) => c.isDeleted.equals(false))).watch();
  }

  Stream<CustomerData?> watchCustomer(int id) {
    return (select(customer)
          ..where((c) => c.id.equals(id) & c.isDeleted.equals(false)))
        .watchSingleOrNull();
  }

  Future<bool> updateCustomerInfo(CustomerData updatedCustomer) {
    return update(customer).replace(updatedCustomer);
  }

  Future<int> deleteCustomer(int id) {
    return (update(customer)..where((c) => c.id.equals(id))).write(
      const CustomerCompanion(isDeleted: Value(true)),
    );
  }

  //  >>>>>>>>>>>>>>> End Of Customer Database Logics <<<<<<<<<<<<<<<<<<
  //  >>>>>>>>>>>>>>> Inventory Database Logics <<<<<<<<<<<<<<<<<<

  Future<int> addInventory({
    required int productId,
    required int quantity,
    required String transactionType,
  }) {
    return into(inventory).insert(
      InventoryCompanion.insert(
        productId: Value(productId),
        tranctionType: transactionType,
        quantity: quantity,
      ),
    );
  }

  Future<int> addCustomInventory({
    required String productName,
    int? quantity,
    required double unitPrice,
    required String transactionType,
  }) {
    return into(inventory).insert(
      InventoryCompanion.insert(
        customName: Value(productName),
        customPrice: Value(unitPrice),
        quantity: quantity ?? 1,
        tranctionType: transactionType,
      ),
    );
  }

  Stream<List<InventoryData>> watchAllInventory() {
    return (select(inventory)..where((i) => i.isDeleted.equals(false))).watch();
  }

  Stream<List<InventoryItemWithProduct>> watchInventoryWithProducts() {
    final query = select(inventory).join([
      leftOuterJoin(product, product.id.equalsExp(inventory.productId)),
    ])..where(inventory.isDeleted.equals(false));

    return query.watch().map(
      (rows) {
        return rows.map(
          (row) {
            return InventoryItemWithProduct(
              inventory: row.readTable(inventory),
              product: row.readTableOrNull(product),
            );
          },
        ).toList();
      },
    );
  }

  Stream<double> watchInventoryTotalValue() {
    return watchInventoryWithProducts().map(
      (items) {
        double total = 0;
        for (final item in items) {
          final price =
              item.inventory.customPrice ?? item.product?.unitPrice ?? 0;
          total += (price * item.inventory.quantity);
        }
        return total;
      },
    );
  }

  Future<bool> updateInventoryQuantity({
    required int id,
    required int newQuantity,
  }) {
    return (update(inventory)..where((i) => i.id.equals(id)))
        .write(InventoryCompanion(quantity: Value(newQuantity)))
        .then((value) => value > 0);
  }

  Future<InventoryData?> getInventoryByProductId(int productId) {
    return (select(inventory)..where(
          (i) => i.productId.equals(productId) & i.isDeleted.equals(false),
        ))
        .getSingleOrNull();
  }

  Future<int> deleteInventory(int id) {
    return (update(inventory)..where((i) => i.id.equals(id))).write(
      const InventoryCompanion(isDeleted: Value(true)),
    );
  }

  Future<InventoryData?> findInventoryByProductId(int productId) {
    return (select(inventory)..where(
          (i) => i.productId.equals(productId) & i.isDeleted.equals(false),
        ))
        .getSingleOrNull();
  }

  Future<InventoryData?> findInventoryByCustomNamePrice(
    String customName,
    double customPrice,
  ) {
    return (select(inventory)
          ..where(
            (i) =>
                i.customName.lower().equals(customName.toLowerCase()) &
                i.customPrice.equals(customPrice) &
                i.isDeleted.equals(false),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<List<InventoryItemWithProduct>> watchInventoryWithProductsByType(
    String type,
  ) {
    final query =
        select(inventory).join([
          leftOuterJoin(product, product.id.equalsExp(inventory.productId)),
        ])..where(
          inventory.tranctionType.equals(type) &
              inventory.isDeleted.equals(false),
        );

    return query.watch().map(
      (rows) {
        return rows.map(
          (row) {
            return InventoryItemWithProduct(
              inventory: row.readTable(inventory),
              product: row.readTableOrNull(product),
            );
          },
        ).toList();
      },
    );
  }

  //  >>>>>>>>>>>>>>> Transaction Master Database Logics <<<<<<<<<<<<<<<<<<

  Future<int> createTransactionMaster({
    required int customerId,
    required double totalAmount,
  }) {
    return into(transactionMaster).insert(
      TransactionMasterCompanion.insert(
        customerId: customerId,
        totalAmount: totalAmount,
      ),
    );
  }

  Stream<List<TransactionMasterData>> watchCustomerTransactions({
    required int customerId,
  }) {
    return (select(transactionMaster)
          ..where(
            (t) => t.customerId.equals(customerId) & t.isDeleted.equals(false),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<TransactionMasterData?> getTransaction(int id) {
    return (select(transactionMaster)
          ..where((t) => t.id.equals(id) & t.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  Future<void> deleteTransactionMaster(int transactionId) async {
    await transaction(() async {
      // 1. Find transaction master record
      final master = await (select(
        transactionMaster,
      )..where((t) => t.id.equals(transactionId))).getSingleOrNull();

      if (master == null) return;

      // 2. Revert Customer Balance
      final customerData = await getCustomerById(master.customerId);
      if (customerData != null) {
        final double revertedBalance =
            customerData.currentBalance - master.totalAmount;

        await (update(
          customer,
        )..where((c) => c.id.equals(master.customerId))).write(
          CustomerCompanion(currentBalance: Value(revertedBalance)),
        );
      }

      // 3. Soft delete associated line items
      await (update(transactionItem)
            ..where((i) => i.transactionId.equals(transactionId)))
          .write(const TransactionItemCompanion(isDeleted: Value(true)));

      // 4. Soft delete transaction master
      await (update(transactionMaster)
            ..where((t) => t.id.equals(transactionId)))
          .write(const TransactionMasterCompanion(isDeleted: Value(true)));
    });
  }
  //  >>>>>>>>>>>>>>> End Of Transaction Master Database Logics <<<<<<<<<<<<<<<<<<
  //  >>>>>>>>>>>>>>> Transaction Items Logics <<<<<<<<<<<<<<<<<<

  Stream<List<TransactionItemData>> watchTransactionItems(int transactionId) {
    return (select(transactionItem)..where(
          (t) =>
              t.transactionId.equals(transactionId) & t.isDeleted.equals(false),
        ))
        .watch();
  }
  //  >>>>>>>>>>>>>>> End Of Transaction Items Logics <<<<<<<<<<<<<<<<<<
  //  >>>>>>>>>>>>>>> Checkout Logic <<<<<<<<<<<<<<<<<<

  Future<void> completeCheckout({
    required int customerId,
    required double netChange,
    required List<CartItem> cartItems,
  }) async {
    await transaction(() async {
      // 1. Create Transaction Master
      final masterId = await into(transactionMaster).insert(
        TransactionMasterCompanion.insert(
          customerId: customerId,
          totalAmount: netChange,
        ),
      );

      // Fetch Customer Data safely without streams inside transaction
      final customerData = await getCustomerById(customerId);
      double runningBalance = customerData?.currentBalance ?? 0.0;

      // 2. Process each cart item
      for (var item in cartItems) {
        await into(transactionItem).insert(
          TransactionItemCompanion.insert(
            transactionId: masterId,
            productId: Value(item.productId),
            productName: item.productName,
            quantity: item.quantity,
            unitPrice: item.unitPrice,
            type: item.type,
          ),
        );

        double itemTotal = item.unitPrice * item.quantity;

        final isCredit =
            item.type == TransactionType.purchase.value ||
            item.type == PaymentType.cashIn.value;

        if (isCredit) {
          runningBalance += itemTotal;
        } else {
          runningBalance -= itemTotal;
        }

        // Insert into CustomerLedger
        await into(customerLedger).insert(
          CustomerLedgerCompanion.insert(
            customerId: customerId,
            productId: Value(item.productId),
            transactionType: item.type,
            quantity: Value(item.quantity),
            unitPrice: Value(item.unitPrice),
            creditAmount: Value(isCredit ? itemTotal : 0),
            debitAmount: Value(!isCredit ? itemTotal : 0),
            balance: runningBalance,
          ),
        );

        // SKIP INVENTORY UPDATE FOR CASH
        if (item.isPayment || item.productId == null) {
          continue;
        }

        // 3. Update Inventory
        final existingInventory = await getInventoryByProductId(
          item.productId!,
        );
        int qtyChange = item.type == TransactionType.purchase.value
            ? item.quantity
            : -item.quantity;

        if (existingInventory != null) {
          await updateInventoryQuantity(
            id: existingInventory.id,
            newQuantity: existingInventory.quantity + qtyChange,
          );
        } else {
          int initialQty = qtyChange < 0 ? 0 : qtyChange;
          await addInventory(
            productId: item.productId!,
            quantity: initialQty,
            transactionType: item.type,
          );
        }
      }

      // 4. Update Customer Balance
      if (customerData != null) {
        await (update(customer)..where((c) => c.id.equals(customerId))).write(
          CustomerCompanion(currentBalance: Value(runningBalance)),
        );
      }
    });
  }
}

// Class for the Inventory and Product
class InventoryItemWithProduct {
  final InventoryData inventory;
  final ProductData? product;

  InventoryItemWithProduct({required this.inventory, this.product});
  // Retrieves custom name if custom item, otherwise falls back to catalog product name
  String get displayName =>
      inventory.customName ?? product?.productName ?? 'Unknown Item';

  // Retrieves custom price if custom item, otherwise falls back to catalog unit price
  double get displayPrice => inventory.customPrice ?? product?.unitPrice ?? 0.0;
}

final appDatabase = AppDatabase();
