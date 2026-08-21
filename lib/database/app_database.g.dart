// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductTable extends Product with TableInfo<$ProductTable, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 40),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productName,
    unitPrice,
    transactionType,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ProductTable createAlias(String alias) {
    return $ProductTable(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final int id;
  final String productName;
  final double unitPrice;
  final String transactionType;
  final bool isDeleted;
  const ProductData({
    required this.id,
    required this.productName,
    required this.unitPrice,
    required this.transactionType,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_name'] = Variable<String>(productName);
    map['unit_price'] = Variable<double>(unitPrice);
    map['transaction_type'] = Variable<String>(transactionType);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      id: Value(id),
      productName: Value(productName),
      unitPrice: Value(unitPrice),
      transactionType: Value(transactionType),
      isDeleted: Value(isDeleted),
    );
  }

  factory ProductData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      id: serializer.fromJson<int>(json['id']),
      productName: serializer.fromJson<String>(json['productName']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productName': serializer.toJson<String>(productName),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'transactionType': serializer.toJson<String>(transactionType),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  ProductData copyWith({
    int? id,
    String? productName,
    double? unitPrice,
    String? transactionType,
    bool? isDeleted,
  }) => ProductData(
    id: id ?? this.id,
    productName: productName ?? this.productName,
    unitPrice: unitPrice ?? this.unitPrice,
    transactionType: transactionType ?? this.transactionType,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  ProductData copyWithCompanion(ProductCompanion data) {
    return ProductData(
      id: data.id.present ? data.id.value : this.id,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('transactionType: $transactionType, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productName, unitPrice, transactionType, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.id == this.id &&
          other.productName == this.productName &&
          other.unitPrice == this.unitPrice &&
          other.transactionType == this.transactionType &&
          other.isDeleted == this.isDeleted);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<int> id;
  final Value<String> productName;
  final Value<double> unitPrice;
  final Value<String> transactionType;
  final Value<bool> isDeleted;
  const ProductCompanion({
    this.id = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  ProductCompanion.insert({
    this.id = const Value.absent(),
    required String productName,
    required double unitPrice,
    required String transactionType,
    this.isDeleted = const Value.absent(),
  }) : productName = Value(productName),
       unitPrice = Value(unitPrice),
       transactionType = Value(transactionType);
  static Insertable<ProductData> custom({
    Expression<int>? id,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<String>? transactionType,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (transactionType != null) 'transaction_type': transactionType,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  ProductCompanion copyWith({
    Value<int>? id,
    Value<String>? productName,
    Value<double>? unitPrice,
    Value<String>? transactionType,
    Value<bool>? isDeleted,
  }) {
    return ProductCompanion(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      transactionType: transactionType ?? this.transactionType,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('transactionType: $transactionType, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CustomerTable extends Customer
    with TableInfo<$CustomerTable, CustomerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 60),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerPhoneNumberMeta =
      const VerificationMeta('customerPhoneNumber');
  @override
  late final GeneratedColumn<String> customerPhoneNumber =
      GeneratedColumn<String>(
        'customer_phone_number',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 10,
          maxTextLength: 15,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _customerAddressMeta = const VerificationMeta(
    'customerAddress',
  );
  @override
  late final GeneratedColumn<String> customerAddress = GeneratedColumn<String>(
    'customer_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentBalanceMeta = const VerificationMeta(
    'currentBalance',
  );
  @override
  late final GeneratedColumn<double> currentBalance = GeneratedColumn<double>(
    'current_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerName,
    customerPhoneNumber,
    customerAddress,
    currentBalance,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('customer_phone_number')) {
      context.handle(
        _customerPhoneNumberMeta,
        customerPhoneNumber.isAcceptableOrUnknown(
          data['customer_phone_number']!,
          _customerPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerPhoneNumberMeta);
    }
    if (data.containsKey('customer_address')) {
      context.handle(
        _customerAddressMeta,
        customerAddress.isAcceptableOrUnknown(
          data['customer_address']!,
          _customerAddressMeta,
        ),
      );
    }
    if (data.containsKey('current_balance')) {
      context.handle(
        _currentBalanceMeta,
        currentBalance.isAcceptableOrUnknown(
          data['current_balance']!,
          _currentBalanceMeta,
        ),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      customerPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_phone_number'],
      )!,
      customerAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_address'],
      ),
      currentBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_balance'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CustomerTable createAlias(String alias) {
    return $CustomerTable(attachedDatabase, alias);
  }
}

class CustomerData extends DataClass implements Insertable<CustomerData> {
  final int id;
  final String customerName;
  final String customerPhoneNumber;
  final String? customerAddress;
  final double currentBalance;
  final bool isDeleted;
  const CustomerData({
    required this.id,
    required this.customerName,
    required this.customerPhoneNumber,
    this.customerAddress,
    required this.currentBalance,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_name'] = Variable<String>(customerName);
    map['customer_phone_number'] = Variable<String>(customerPhoneNumber);
    if (!nullToAbsent || customerAddress != null) {
      map['customer_address'] = Variable<String>(customerAddress);
    }
    map['current_balance'] = Variable<double>(currentBalance);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CustomerCompanion toCompanion(bool nullToAbsent) {
    return CustomerCompanion(
      id: Value(id),
      customerName: Value(customerName),
      customerPhoneNumber: Value(customerPhoneNumber),
      customerAddress: customerAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(customerAddress),
      currentBalance: Value(currentBalance),
      isDeleted: Value(isDeleted),
    );
  }

  factory CustomerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerData(
      id: serializer.fromJson<int>(json['id']),
      customerName: serializer.fromJson<String>(json['customerName']),
      customerPhoneNumber: serializer.fromJson<String>(
        json['customerPhoneNumber'],
      ),
      customerAddress: serializer.fromJson<String?>(json['customerAddress']),
      currentBalance: serializer.fromJson<double>(json['currentBalance']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerName': serializer.toJson<String>(customerName),
      'customerPhoneNumber': serializer.toJson<String>(customerPhoneNumber),
      'customerAddress': serializer.toJson<String?>(customerAddress),
      'currentBalance': serializer.toJson<double>(currentBalance),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  CustomerData copyWith({
    int? id,
    String? customerName,
    String? customerPhoneNumber,
    Value<String?> customerAddress = const Value.absent(),
    double? currentBalance,
    bool? isDeleted,
  }) => CustomerData(
    id: id ?? this.id,
    customerName: customerName ?? this.customerName,
    customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
    customerAddress: customerAddress.present
        ? customerAddress.value
        : this.customerAddress,
    currentBalance: currentBalance ?? this.currentBalance,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  CustomerData copyWithCompanion(CustomerCompanion data) {
    return CustomerData(
      id: data.id.present ? data.id.value : this.id,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerPhoneNumber: data.customerPhoneNumber.present
          ? data.customerPhoneNumber.value
          : this.customerPhoneNumber,
      customerAddress: data.customerAddress.present
          ? data.customerAddress.value
          : this.customerAddress,
      currentBalance: data.currentBalance.present
          ? data.currentBalance.value
          : this.currentBalance,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerData(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhoneNumber: $customerPhoneNumber, ')
          ..write('customerAddress: $customerAddress, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerName,
    customerPhoneNumber,
    customerAddress,
    currentBalance,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerData &&
          other.id == this.id &&
          other.customerName == this.customerName &&
          other.customerPhoneNumber == this.customerPhoneNumber &&
          other.customerAddress == this.customerAddress &&
          other.currentBalance == this.currentBalance &&
          other.isDeleted == this.isDeleted);
}

class CustomerCompanion extends UpdateCompanion<CustomerData> {
  final Value<int> id;
  final Value<String> customerName;
  final Value<String> customerPhoneNumber;
  final Value<String?> customerAddress;
  final Value<double> currentBalance;
  final Value<bool> isDeleted;
  const CustomerCompanion({
    this.id = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhoneNumber = const Value.absent(),
    this.customerAddress = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CustomerCompanion.insert({
    this.id = const Value.absent(),
    required String customerName,
    required String customerPhoneNumber,
    this.customerAddress = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : customerName = Value(customerName),
       customerPhoneNumber = Value(customerPhoneNumber);
  static Insertable<CustomerData> custom({
    Expression<int>? id,
    Expression<String>? customerName,
    Expression<String>? customerPhoneNumber,
    Expression<String>? customerAddress,
    Expression<double>? currentBalance,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhoneNumber != null)
        'customer_phone_number': customerPhoneNumber,
      if (customerAddress != null) 'customer_address': customerAddress,
      if (currentBalance != null) 'current_balance': currentBalance,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CustomerCompanion copyWith({
    Value<int>? id,
    Value<String>? customerName,
    Value<String>? customerPhoneNumber,
    Value<String?>? customerAddress,
    Value<double>? currentBalance,
    Value<bool>? isDeleted,
  }) {
    return CustomerCompanion(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      customerAddress: customerAddress ?? this.customerAddress,
      currentBalance: currentBalance ?? this.currentBalance,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerPhoneNumber.present) {
      map['customer_phone_number'] = Variable<String>(
        customerPhoneNumber.value,
      );
    }
    if (customerAddress.present) {
      map['customer_address'] = Variable<String>(customerAddress.value);
    }
    if (currentBalance.present) {
      map['current_balance'] = Variable<double>(currentBalance.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerCompanion(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhoneNumber: $customerPhoneNumber, ')
          ..write('customerAddress: $customerAddress, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $InventoryTable extends Inventory
    with TableInfo<$InventoryTable, InventoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product (id)',
    ),
  );
  static const VerificationMeta _customNameMeta = const VerificationMeta(
    'customName',
  );
  @override
  late final GeneratedColumn<String> customName = GeneratedColumn<String>(
    'custom_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customPriceMeta = const VerificationMeta(
    'customPrice',
  );
  @override
  late final GeneratedColumn<double> customPrice = GeneratedColumn<double>(
    'custom_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tranctionTypeMeta = const VerificationMeta(
    'tranctionType',
  );
  @override
  late final GeneratedColumn<String> tranctionType = GeneratedColumn<String>(
    'tranction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    customName,
    customPrice,
    quantity,
    tranctionType,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('custom_name')) {
      context.handle(
        _customNameMeta,
        customName.isAcceptableOrUnknown(data['custom_name']!, _customNameMeta),
      );
    }
    if (data.containsKey('custom_price')) {
      context.handle(
        _customPriceMeta,
        customPrice.isAcceptableOrUnknown(
          data['custom_price']!,
          _customPriceMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('tranction_type')) {
      context.handle(
        _tranctionTypeMeta,
        tranctionType.isAcceptableOrUnknown(
          data['tranction_type']!,
          _tranctionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tranctionTypeMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      customName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_name'],
      ),
      customPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}custom_price'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      tranctionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tranction_type'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $InventoryTable createAlias(String alias) {
    return $InventoryTable(attachedDatabase, alias);
  }
}

class InventoryData extends DataClass implements Insertable<InventoryData> {
  final int id;
  final int? productId;
  final String? customName;
  final double? customPrice;
  final int quantity;
  final String tranctionType;
  final bool isDeleted;
  const InventoryData({
    required this.id,
    this.productId,
    this.customName,
    this.customPrice,
    required this.quantity,
    required this.tranctionType,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || customName != null) {
      map['custom_name'] = Variable<String>(customName);
    }
    if (!nullToAbsent || customPrice != null) {
      map['custom_price'] = Variable<double>(customPrice);
    }
    map['quantity'] = Variable<int>(quantity);
    map['tranction_type'] = Variable<String>(tranctionType);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  InventoryCompanion toCompanion(bool nullToAbsent) {
    return InventoryCompanion(
      id: Value(id),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      customName: customName == null && nullToAbsent
          ? const Value.absent()
          : Value(customName),
      customPrice: customPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(customPrice),
      quantity: Value(quantity),
      tranctionType: Value(tranctionType),
      isDeleted: Value(isDeleted),
    );
  }

  factory InventoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryData(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int?>(json['productId']),
      customName: serializer.fromJson<String?>(json['customName']),
      customPrice: serializer.fromJson<double?>(json['customPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      tranctionType: serializer.fromJson<String>(json['tranctionType']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int?>(productId),
      'customName': serializer.toJson<String?>(customName),
      'customPrice': serializer.toJson<double?>(customPrice),
      'quantity': serializer.toJson<int>(quantity),
      'tranctionType': serializer.toJson<String>(tranctionType),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  InventoryData copyWith({
    int? id,
    Value<int?> productId = const Value.absent(),
    Value<String?> customName = const Value.absent(),
    Value<double?> customPrice = const Value.absent(),
    int? quantity,
    String? tranctionType,
    bool? isDeleted,
  }) => InventoryData(
    id: id ?? this.id,
    productId: productId.present ? productId.value : this.productId,
    customName: customName.present ? customName.value : this.customName,
    customPrice: customPrice.present ? customPrice.value : this.customPrice,
    quantity: quantity ?? this.quantity,
    tranctionType: tranctionType ?? this.tranctionType,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  InventoryData copyWithCompanion(InventoryCompanion data) {
    return InventoryData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      customName: data.customName.present
          ? data.customName.value
          : this.customName,
      customPrice: data.customPrice.present
          ? data.customPrice.value
          : this.customPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      tranctionType: data.tranctionType.present
          ? data.tranctionType.value
          : this.tranctionType,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('customName: $customName, ')
          ..write('customPrice: $customPrice, ')
          ..write('quantity: $quantity, ')
          ..write('tranctionType: $tranctionType, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    customName,
    customPrice,
    quantity,
    tranctionType,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.customName == this.customName &&
          other.customPrice == this.customPrice &&
          other.quantity == this.quantity &&
          other.tranctionType == this.tranctionType &&
          other.isDeleted == this.isDeleted);
}

class InventoryCompanion extends UpdateCompanion<InventoryData> {
  final Value<int> id;
  final Value<int?> productId;
  final Value<String?> customName;
  final Value<double?> customPrice;
  final Value<int> quantity;
  final Value<String> tranctionType;
  final Value<bool> isDeleted;
  const InventoryCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.customName = const Value.absent(),
    this.customPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.tranctionType = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  InventoryCompanion.insert({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.customName = const Value.absent(),
    this.customPrice = const Value.absent(),
    required int quantity,
    required String tranctionType,
    this.isDeleted = const Value.absent(),
  }) : quantity = Value(quantity),
       tranctionType = Value(tranctionType);
  static Insertable<InventoryData> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? customName,
    Expression<double>? customPrice,
    Expression<int>? quantity,
    Expression<String>? tranctionType,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (customName != null) 'custom_name': customName,
      if (customPrice != null) 'custom_price': customPrice,
      if (quantity != null) 'quantity': quantity,
      if (tranctionType != null) 'tranction_type': tranctionType,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  InventoryCompanion copyWith({
    Value<int>? id,
    Value<int?>? productId,
    Value<String?>? customName,
    Value<double?>? customPrice,
    Value<int>? quantity,
    Value<String>? tranctionType,
    Value<bool>? isDeleted,
  }) {
    return InventoryCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      customName: customName ?? this.customName,
      customPrice: customPrice ?? this.customPrice,
      quantity: quantity ?? this.quantity,
      tranctionType: tranctionType ?? this.tranctionType,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (customName.present) {
      map['custom_name'] = Variable<String>(customName.value);
    }
    if (customPrice.present) {
      map['custom_price'] = Variable<double>(customPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (tranctionType.present) {
      map['tranction_type'] = Variable<String>(tranctionType.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('customName: $customName, ')
          ..write('customPrice: $customPrice, ')
          ..write('quantity: $quantity, ')
          ..write('tranctionType: $tranctionType, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $TransactionMasterTable extends TransactionMaster
    with TableInfo<$TransactionMasterTable, TransactionMasterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionMasterTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer (id)',
    ),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    totalAmount,
    createdAt,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_master';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionMasterData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionMasterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionMasterData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $TransactionMasterTable createAlias(String alias) {
    return $TransactionMasterTable(attachedDatabase, alias);
  }
}

class TransactionMasterData extends DataClass
    implements Insertable<TransactionMasterData> {
  final int id;
  final int customerId;
  final double totalAmount;
  final DateTime createdAt;
  final bool isDeleted;
  const TransactionMasterData({
    required this.id,
    required this.customerId,
    required this.totalAmount,
    required this.createdAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['total_amount'] = Variable<double>(totalAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  TransactionMasterCompanion toCompanion(bool nullToAbsent) {
    return TransactionMasterCompanion(
      id: Value(id),
      customerId: Value(customerId),
      totalAmount: Value(totalAmount),
      createdAt: Value(createdAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory TransactionMasterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionMasterData(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  TransactionMasterData copyWith({
    int? id,
    int? customerId,
    double? totalAmount,
    DateTime? createdAt,
    bool? isDeleted,
  }) => TransactionMasterData(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    totalAmount: totalAmount ?? this.totalAmount,
    createdAt: createdAt ?? this.createdAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  TransactionMasterData copyWithCompanion(TransactionMasterCompanion data) {
    return TransactionMasterData(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionMasterData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerId, totalAmount, createdAt, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionMasterData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.totalAmount == this.totalAmount &&
          other.createdAt == this.createdAt &&
          other.isDeleted == this.isDeleted);
}

class TransactionMasterCompanion
    extends UpdateCompanion<TransactionMasterData> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<double> totalAmount;
  final Value<DateTime> createdAt;
  final Value<bool> isDeleted;
  const TransactionMasterCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  TransactionMasterCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required double totalAmount,
    this.createdAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : customerId = Value(customerId),
       totalAmount = Value(totalAmount);
  static Insertable<TransactionMasterData> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<double>? totalAmount,
    Expression<DateTime>? createdAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (createdAt != null) 'created_at': createdAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  TransactionMasterCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<double>? totalAmount,
    Value<DateTime>? createdAt,
    Value<bool>? isDeleted,
  }) {
    return TransactionMasterCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionMasterCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $TransactionItemTable extends TransactionItem
    with TableInfo<$TransactionItemTable, TransactionItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transaction_master (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionId,
    productId,
    productName,
    unitPrice,
    quantity,
    type,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_item';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionItemData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionItemData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $TransactionItemTable createAlias(String alias) {
    return $TransactionItemTable(attachedDatabase, alias);
  }
}

class TransactionItemData extends DataClass
    implements Insertable<TransactionItemData> {
  final int id;
  final int transactionId;
  final int? productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final String type;
  final bool isDeleted;
  const TransactionItemData({
    required this.id,
    required this.transactionId,
    this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.type,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_id'] = Variable<int>(transactionId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    map['product_name'] = Variable<String>(productName);
    map['unit_price'] = Variable<double>(unitPrice);
    map['quantity'] = Variable<int>(quantity);
    map['type'] = Variable<String>(type);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  TransactionItemCompanion toCompanion(bool nullToAbsent) {
    return TransactionItemCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      productName: Value(productName),
      unitPrice: Value(unitPrice),
      quantity: Value(quantity),
      type: Value(type),
      isDeleted: Value(isDeleted),
    );
  }

  factory TransactionItemData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionItemData(
      id: serializer.fromJson<int>(json['id']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      productId: serializer.fromJson<int?>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      type: serializer.fromJson<String>(json['type']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionId': serializer.toJson<int>(transactionId),
      'productId': serializer.toJson<int?>(productId),
      'productName': serializer.toJson<String>(productName),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'quantity': serializer.toJson<int>(quantity),
      'type': serializer.toJson<String>(type),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  TransactionItemData copyWith({
    int? id,
    int? transactionId,
    Value<int?> productId = const Value.absent(),
    String? productName,
    double? unitPrice,
    int? quantity,
    String? type,
    bool? isDeleted,
  }) => TransactionItemData(
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    productId: productId.present ? productId.value : this.productId,
    productName: productName ?? this.productName,
    unitPrice: unitPrice ?? this.unitPrice,
    quantity: quantity ?? this.quantity,
    type: type ?? this.type,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  TransactionItemData copyWithCompanion(TransactionItemCompanion data) {
    return TransactionItemData(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      type: data.type.present ? data.type.value : this.type,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionItemData(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('type: $type, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transactionId,
    productId,
    productName,
    unitPrice,
    quantity,
    type,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionItemData &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.unitPrice == this.unitPrice &&
          other.quantity == this.quantity &&
          other.type == this.type &&
          other.isDeleted == this.isDeleted);
}

class TransactionItemCompanion extends UpdateCompanion<TransactionItemData> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<int?> productId;
  final Value<String> productName;
  final Value<double> unitPrice;
  final Value<int> quantity;
  final Value<String> type;
  final Value<bool> isDeleted;
  const TransactionItemCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.type = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  TransactionItemCompanion.insert({
    this.id = const Value.absent(),
    required int transactionId,
    this.productId = const Value.absent(),
    required String productName,
    required double unitPrice,
    required int quantity,
    required String type,
    this.isDeleted = const Value.absent(),
  }) : transactionId = Value(transactionId),
       productName = Value(productName),
       unitPrice = Value(unitPrice),
       quantity = Value(quantity),
       type = Value(type);
  static Insertable<TransactionItemData> custom({
    Expression<int>? id,
    Expression<int>? transactionId,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<int>? quantity,
    Expression<String>? type,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (quantity != null) 'quantity': quantity,
      if (type != null) 'type': type,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  TransactionItemCompanion copyWith({
    Value<int>? id,
    Value<int>? transactionId,
    Value<int?>? productId,
    Value<String>? productName,
    Value<double>? unitPrice,
    Value<int>? quantity,
    Value<String>? type,
    Value<bool>? isDeleted,
  }) {
    return TransactionItemCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionItemCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('type: $type, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CustomerLedgerTable extends CustomerLedger
    with TableInfo<$CustomerLedgerTable, CustomerLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product (id)',
    ),
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditAmountMeta = const VerificationMeta(
    'creditAmount',
  );
  @override
  late final GeneratedColumn<double> creditAmount = GeneratedColumn<double>(
    'credit_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _debitAmountMeta = const VerificationMeta(
    'debitAmount',
  );
  @override
  late final GeneratedColumn<double> debitAmount = GeneratedColumn<double>(
    'debit_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paymentAmountMeta = const VerificationMeta(
    'paymentAmount',
  );
  @override
  late final GeneratedColumn<double> paymentAmount = GeneratedColumn<double>(
    'payment_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    productId,
    transactionType,
    quantity,
    unitPrice,
    creditAmount,
    debitAmount,
    paymentAmount,
    balance,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerLedgerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('credit_amount')) {
      context.handle(
        _creditAmountMeta,
        creditAmount.isAcceptableOrUnknown(
          data['credit_amount']!,
          _creditAmountMeta,
        ),
      );
    }
    if (data.containsKey('debit_amount')) {
      context.handle(
        _debitAmountMeta,
        debitAmount.isAcceptableOrUnknown(
          data['debit_amount']!,
          _debitAmountMeta,
        ),
      );
    }
    if (data.containsKey('payment_amount')) {
      context.handle(
        _paymentAmountMeta,
        paymentAmount.isAcceptableOrUnknown(
          data['payment_amount']!,
          _paymentAmountMeta,
        ),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerLedgerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      ),
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      ),
      creditAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_amount'],
      )!,
      debitAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}debit_amount'],
      )!,
      paymentAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payment_amount'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomerLedgerTable createAlias(String alias) {
    return $CustomerLedgerTable(attachedDatabase, alias);
  }
}

class CustomerLedgerData extends DataClass
    implements Insertable<CustomerLedgerData> {
  final int id;
  final int customerId;
  final int? productId;
  final String transactionType;
  final int? quantity;
  final double? unitPrice;
  final double creditAmount;
  final double debitAmount;
  final double paymentAmount;
  final double balance;
  final DateTime createdAt;
  const CustomerLedgerData({
    required this.id,
    required this.customerId,
    this.productId,
    required this.transactionType,
    this.quantity,
    this.unitPrice,
    required this.creditAmount,
    required this.debitAmount,
    required this.paymentAmount,
    required this.balance,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    map['transaction_type'] = Variable<String>(transactionType);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || unitPrice != null) {
      map['unit_price'] = Variable<double>(unitPrice);
    }
    map['credit_amount'] = Variable<double>(creditAmount);
    map['debit_amount'] = Variable<double>(debitAmount);
    map['payment_amount'] = Variable<double>(paymentAmount);
    map['balance'] = Variable<double>(balance);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomerLedgerCompanion toCompanion(bool nullToAbsent) {
    return CustomerLedgerCompanion(
      id: Value(id),
      customerId: Value(customerId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      transactionType: Value(transactionType),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      unitPrice: unitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPrice),
      creditAmount: Value(creditAmount),
      debitAmount: Value(debitAmount),
      paymentAmount: Value(paymentAmount),
      balance: Value(balance),
      createdAt: Value(createdAt),
    );
  }

  factory CustomerLedgerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerLedgerData(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      productId: serializer.fromJson<int?>(json['productId']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      unitPrice: serializer.fromJson<double?>(json['unitPrice']),
      creditAmount: serializer.fromJson<double>(json['creditAmount']),
      debitAmount: serializer.fromJson<double>(json['debitAmount']),
      paymentAmount: serializer.fromJson<double>(json['paymentAmount']),
      balance: serializer.fromJson<double>(json['balance']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'productId': serializer.toJson<int?>(productId),
      'transactionType': serializer.toJson<String>(transactionType),
      'quantity': serializer.toJson<int?>(quantity),
      'unitPrice': serializer.toJson<double?>(unitPrice),
      'creditAmount': serializer.toJson<double>(creditAmount),
      'debitAmount': serializer.toJson<double>(debitAmount),
      'paymentAmount': serializer.toJson<double>(paymentAmount),
      'balance': serializer.toJson<double>(balance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerLedgerData copyWith({
    int? id,
    int? customerId,
    Value<int?> productId = const Value.absent(),
    String? transactionType,
    Value<int?> quantity = const Value.absent(),
    Value<double?> unitPrice = const Value.absent(),
    double? creditAmount,
    double? debitAmount,
    double? paymentAmount,
    double? balance,
    DateTime? createdAt,
  }) => CustomerLedgerData(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    productId: productId.present ? productId.value : this.productId,
    transactionType: transactionType ?? this.transactionType,
    quantity: quantity.present ? quantity.value : this.quantity,
    unitPrice: unitPrice.present ? unitPrice.value : this.unitPrice,
    creditAmount: creditAmount ?? this.creditAmount,
    debitAmount: debitAmount ?? this.debitAmount,
    paymentAmount: paymentAmount ?? this.paymentAmount,
    balance: balance ?? this.balance,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomerLedgerData copyWithCompanion(CustomerLedgerCompanion data) {
    return CustomerLedgerData(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      productId: data.productId.present ? data.productId.value : this.productId,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      creditAmount: data.creditAmount.present
          ? data.creditAmount.value
          : this.creditAmount,
      debitAmount: data.debitAmount.present
          ? data.debitAmount.value
          : this.debitAmount,
      paymentAmount: data.paymentAmount.present
          ? data.paymentAmount.value
          : this.paymentAmount,
      balance: data.balance.present ? data.balance.value : this.balance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerLedgerData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('productId: $productId, ')
          ..write('transactionType: $transactionType, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('creditAmount: $creditAmount, ')
          ..write('debitAmount: $debitAmount, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('balance: $balance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    productId,
    transactionType,
    quantity,
    unitPrice,
    creditAmount,
    debitAmount,
    paymentAmount,
    balance,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerLedgerData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.productId == this.productId &&
          other.transactionType == this.transactionType &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.creditAmount == this.creditAmount &&
          other.debitAmount == this.debitAmount &&
          other.paymentAmount == this.paymentAmount &&
          other.balance == this.balance &&
          other.createdAt == this.createdAt);
}

class CustomerLedgerCompanion extends UpdateCompanion<CustomerLedgerData> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int?> productId;
  final Value<String> transactionType;
  final Value<int?> quantity;
  final Value<double?> unitPrice;
  final Value<double> creditAmount;
  final Value<double> debitAmount;
  final Value<double> paymentAmount;
  final Value<double> balance;
  final Value<DateTime> createdAt;
  const CustomerLedgerCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.productId = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.creditAmount = const Value.absent(),
    this.debitAmount = const Value.absent(),
    this.paymentAmount = const Value.absent(),
    this.balance = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomerLedgerCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    this.productId = const Value.absent(),
    required String transactionType,
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.creditAmount = const Value.absent(),
    this.debitAmount = const Value.absent(),
    this.paymentAmount = const Value.absent(),
    required double balance,
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       transactionType = Value(transactionType),
       balance = Value(balance);
  static Insertable<CustomerLedgerData> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? productId,
    Expression<String>? transactionType,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? creditAmount,
    Expression<double>? debitAmount,
    Expression<double>? paymentAmount,
    Expression<double>? balance,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (productId != null) 'product_id': productId,
      if (transactionType != null) 'transaction_type': transactionType,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (creditAmount != null) 'credit_amount': creditAmount,
      if (debitAmount != null) 'debit_amount': debitAmount,
      if (paymentAmount != null) 'payment_amount': paymentAmount,
      if (balance != null) 'balance': balance,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomerLedgerCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<int?>? productId,
    Value<String>? transactionType,
    Value<int?>? quantity,
    Value<double?>? unitPrice,
    Value<double>? creditAmount,
    Value<double>? debitAmount,
    Value<double>? paymentAmount,
    Value<double>? balance,
    Value<DateTime>? createdAt,
  }) {
    return CustomerLedgerCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      transactionType: transactionType ?? this.transactionType,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      creditAmount: creditAmount ?? this.creditAmount,
      debitAmount: debitAmount ?? this.debitAmount,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      balance: balance ?? this.balance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (creditAmount.present) {
      map['credit_amount'] = Variable<double>(creditAmount.value);
    }
    if (debitAmount.present) {
      map['debit_amount'] = Variable<double>(debitAmount.value);
    }
    if (paymentAmount.present) {
      map['payment_amount'] = Variable<double>(paymentAmount.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerLedgerCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('productId: $productId, ')
          ..write('transactionType: $transactionType, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('creditAmount: $creditAmount, ')
          ..write('debitAmount: $debitAmount, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('balance: $balance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductTable product = $ProductTable(this);
  late final $CustomerTable customer = $CustomerTable(this);
  late final $InventoryTable inventory = $InventoryTable(this);
  late final $TransactionMasterTable transactionMaster =
      $TransactionMasterTable(this);
  late final $TransactionItemTable transactionItem = $TransactionItemTable(
    this,
  );
  late final $CustomerLedgerTable customerLedger = $CustomerLedgerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    product,
    customer,
    inventory,
    transactionMaster,
    transactionItem,
    customerLedger,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'product',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transaction_item', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$ProductTableCreateCompanionBuilder =
    ProductCompanion Function({
      Value<int> id,
      required String productName,
      required double unitPrice,
      required String transactionType,
      Value<bool> isDeleted,
    });
typedef $$ProductTableUpdateCompanionBuilder =
    ProductCompanion Function({
      Value<int> id,
      Value<String> productName,
      Value<double> unitPrice,
      Value<String> transactionType,
      Value<bool> isDeleted,
    });

final class $$ProductTableReferences
    extends BaseReferences<_$AppDatabase, $ProductTable, ProductData> {
  $$ProductTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InventoryTable, List<InventoryData>>
  _inventoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inventory,
    aliasName: 'product__id__inventory__product_id',
  );

  $$InventoryTableProcessedTableManager get inventoryRefs {
    final manager = $$InventoryTableTableManager(
      $_db,
      $_db.inventory,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransactionItemTable, List<TransactionItemData>>
  _transactionItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactionItem,
    aliasName: 'product__id__transaction_item__product_id',
  );

  $$TransactionItemTableProcessedTableManager get transactionItemRefs {
    final manager = $$TransactionItemTableTableManager(
      $_db,
      $_db.transactionItem,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionItemRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomerLedgerTable, List<CustomerLedgerData>>
  _customerLedgerRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customerLedger,
    aliasName: 'product__id__customer_ledger__product_id',
  );

  $$CustomerLedgerTableProcessedTableManager get customerLedgerRefs {
    final manager = $$CustomerLedgerTableTableManager(
      $_db,
      $_db.customerLedger,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerLedgerRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventoryRefs(
    Expression<bool> Function($$InventoryTableFilterComposer f) f,
  ) {
    final $$InventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventory,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryTableFilterComposer(
            $db: $db,
            $table: $db.inventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionItemRefs(
    Expression<bool> Function($$TransactionItemTableFilterComposer f) f,
  ) {
    final $$TransactionItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionItem,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionItemTableFilterComposer(
            $db: $db,
            $table: $db.transactionItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerLedgerRefs(
    Expression<bool> Function($$CustomerLedgerTableFilterComposer f) f,
  ) {
    final $$CustomerLedgerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerLedger,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerLedgerTableFilterComposer(
            $db: $db,
            $table: $db.customerLedger,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> inventoryRefs<T extends Object>(
    Expression<T> Function($$InventoryTableAnnotationComposer a) f,
  ) {
    final $$InventoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventory,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryTableAnnotationComposer(
            $db: $db,
            $table: $db.inventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionItemRefs<T extends Object>(
    Expression<T> Function($$TransactionItemTableAnnotationComposer a) f,
  ) {
    final $$TransactionItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionItem,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionItemTableAnnotationComposer(
            $db: $db,
            $table: $db.transactionItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerLedgerRefs<T extends Object>(
    Expression<T> Function($$CustomerLedgerTableAnnotationComposer a) f,
  ) {
    final $$CustomerLedgerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerLedger,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerLedgerTableAnnotationComposer(
            $db: $db,
            $table: $db.customerLedger,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTable,
          ProductData,
          $$ProductTableFilterComposer,
          $$ProductTableOrderingComposer,
          $$ProductTableAnnotationComposer,
          $$ProductTableCreateCompanionBuilder,
          $$ProductTableUpdateCompanionBuilder,
          (ProductData, $$ProductTableReferences),
          ProductData,
          PrefetchHooks Function({
            bool inventoryRefs,
            bool transactionItemRefs,
            bool customerLedgerRefs,
          })
        > {
  $$ProductTableTableManager(_$AppDatabase db, $ProductTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ProductCompanion(
                id: id,
                productName: productName,
                unitPrice: unitPrice,
                transactionType: transactionType,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productName,
                required double unitPrice,
                required String transactionType,
                Value<bool> isDeleted = const Value.absent(),
              }) => ProductCompanion.insert(
                id: id,
                productName: productName,
                unitPrice: unitPrice,
                transactionType: transactionType,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                inventoryRefs = false,
                transactionItemRefs = false,
                customerLedgerRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inventoryRefs) db.inventory,
                    if (transactionItemRefs) db.transactionItem,
                    if (customerLedgerRefs) db.customerLedger,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inventoryRefs)
                        await $_getPrefetchedData<
                          ProductData,
                          $ProductTable,
                          InventoryData
                        >(
                          currentTable: table,
                          referencedTable: $$ProductTableReferences
                              ._inventoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transactionItemRefs)
                        await $_getPrefetchedData<
                          ProductData,
                          $ProductTable,
                          TransactionItemData
                        >(
                          currentTable: table,
                          referencedTable: $$ProductTableReferences
                              ._transactionItemRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionItemRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customerLedgerRefs)
                        await $_getPrefetchedData<
                          ProductData,
                          $ProductTable,
                          CustomerLedgerData
                        >(
                          currentTable: table,
                          referencedTable: $$ProductTableReferences
                              ._customerLedgerRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductTableReferences(
                                db,
                                table,
                                p0,
                              ).customerLedgerRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTable,
      ProductData,
      $$ProductTableFilterComposer,
      $$ProductTableOrderingComposer,
      $$ProductTableAnnotationComposer,
      $$ProductTableCreateCompanionBuilder,
      $$ProductTableUpdateCompanionBuilder,
      (ProductData, $$ProductTableReferences),
      ProductData,
      PrefetchHooks Function({
        bool inventoryRefs,
        bool transactionItemRefs,
        bool customerLedgerRefs,
      })
    >;
typedef $$CustomerTableCreateCompanionBuilder =
    CustomerCompanion Function({
      Value<int> id,
      required String customerName,
      required String customerPhoneNumber,
      Value<String?> customerAddress,
      Value<double> currentBalance,
      Value<bool> isDeleted,
    });
typedef $$CustomerTableUpdateCompanionBuilder =
    CustomerCompanion Function({
      Value<int> id,
      Value<String> customerName,
      Value<String> customerPhoneNumber,
      Value<String?> customerAddress,
      Value<double> currentBalance,
      Value<bool> isDeleted,
    });

final class $$CustomerTableReferences
    extends BaseReferences<_$AppDatabase, $CustomerTable, CustomerData> {
  $$CustomerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $TransactionMasterTable,
    List<TransactionMasterData>
  >
  _transactionMasterRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionMaster,
        aliasName: 'customer__id__transaction_master__customer_id',
      );

  $$TransactionMasterTableProcessedTableManager get transactionMasterRefs {
    final manager = $$TransactionMasterTableTableManager(
      $_db,
      $_db.transactionMaster,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionMasterRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomerLedgerTable, List<CustomerLedgerData>>
  _customerLedgerRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customerLedger,
    aliasName: 'customer__id__customer_ledger__customer_id',
  );

  $$CustomerLedgerTableProcessedTableManager get customerLedgerRefs {
    final manager = $$CustomerLedgerTableTableManager(
      $_db,
      $_db.customerLedger,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerLedgerRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomerTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerTable> {
  $$CustomerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerPhoneNumber => $composableBuilder(
    column: $table.customerPhoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerAddress => $composableBuilder(
    column: $table.customerAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionMasterRefs(
    Expression<bool> Function($$TransactionMasterTableFilterComposer f) f,
  ) {
    final $$TransactionMasterTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionMaster,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionMasterTableFilterComposer(
            $db: $db,
            $table: $db.transactionMaster,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerLedgerRefs(
    Expression<bool> Function($$CustomerLedgerTableFilterComposer f) f,
  ) {
    final $$CustomerLedgerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerLedger,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerLedgerTableFilterComposer(
            $db: $db,
            $table: $db.customerLedger,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomerTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerTable> {
  $$CustomerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerPhoneNumber => $composableBuilder(
    column: $table.customerPhoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerAddress => $composableBuilder(
    column: $table.customerAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerTable> {
  $$CustomerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerPhoneNumber => $composableBuilder(
    column: $table.customerPhoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerAddress => $composableBuilder(
    column: $table.customerAddress,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> transactionMasterRefs<T extends Object>(
    Expression<T> Function($$TransactionMasterTableAnnotationComposer a) f,
  ) {
    final $$TransactionMasterTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionMaster,
          getReferencedColumn: (t) => t.customerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionMasterTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionMaster,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> customerLedgerRefs<T extends Object>(
    Expression<T> Function($$CustomerLedgerTableAnnotationComposer a) f,
  ) {
    final $$CustomerLedgerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerLedger,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerLedgerTableAnnotationComposer(
            $db: $db,
            $table: $db.customerLedger,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerTable,
          CustomerData,
          $$CustomerTableFilterComposer,
          $$CustomerTableOrderingComposer,
          $$CustomerTableAnnotationComposer,
          $$CustomerTableCreateCompanionBuilder,
          $$CustomerTableUpdateCompanionBuilder,
          (CustomerData, $$CustomerTableReferences),
          CustomerData,
          PrefetchHooks Function({
            bool transactionMasterRefs,
            bool customerLedgerRefs,
          })
        > {
  $$CustomerTableTableManager(_$AppDatabase db, $CustomerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> customerPhoneNumber = const Value.absent(),
                Value<String?> customerAddress = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CustomerCompanion(
                id: id,
                customerName: customerName,
                customerPhoneNumber: customerPhoneNumber,
                customerAddress: customerAddress,
                currentBalance: currentBalance,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String customerName,
                required String customerPhoneNumber,
                Value<String?> customerAddress = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CustomerCompanion.insert(
                id: id,
                customerName: customerName,
                customerPhoneNumber: customerPhoneNumber,
                customerAddress: customerAddress,
                currentBalance: currentBalance,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomerTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({transactionMasterRefs = false, customerLedgerRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionMasterRefs) db.transactionMaster,
                    if (customerLedgerRefs) db.customerLedger,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionMasterRefs)
                        await $_getPrefetchedData<
                          CustomerData,
                          $CustomerTable,
                          TransactionMasterData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomerTableReferences
                              ._transactionMasterRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomerTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionMasterRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customerLedgerRefs)
                        await $_getPrefetchedData<
                          CustomerData,
                          $CustomerTable,
                          CustomerLedgerData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomerTableReferences
                              ._customerLedgerRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomerTableReferences(
                                db,
                                table,
                                p0,
                              ).customerLedgerRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CustomerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerTable,
      CustomerData,
      $$CustomerTableFilterComposer,
      $$CustomerTableOrderingComposer,
      $$CustomerTableAnnotationComposer,
      $$CustomerTableCreateCompanionBuilder,
      $$CustomerTableUpdateCompanionBuilder,
      (CustomerData, $$CustomerTableReferences),
      CustomerData,
      PrefetchHooks Function({
        bool transactionMasterRefs,
        bool customerLedgerRefs,
      })
    >;
typedef $$InventoryTableCreateCompanionBuilder =
    InventoryCompanion Function({
      Value<int> id,
      Value<int?> productId,
      Value<String?> customName,
      Value<double?> customPrice,
      required int quantity,
      required String tranctionType,
      Value<bool> isDeleted,
    });
typedef $$InventoryTableUpdateCompanionBuilder =
    InventoryCompanion Function({
      Value<int> id,
      Value<int?> productId,
      Value<String?> customName,
      Value<double?> customPrice,
      Value<int> quantity,
      Value<String> tranctionType,
      Value<bool> isDeleted,
    });

final class $$InventoryTableReferences
    extends BaseReferences<_$AppDatabase, $InventoryTable, InventoryData> {
  $$InventoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductTable _productIdTable(_$AppDatabase db) =>
      db.product.createAlias('inventory__product_id__product__id');

  $$ProductTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductTableTableManager(
      $_db,
      $_db.product,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryTable> {
  $$InventoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get customPrice => $composableBuilder(
    column: $table.customPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tranctionType => $composableBuilder(
    column: $table.tranctionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductTableFilterComposer get productId {
    final $$ProductTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableFilterComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryTable> {
  $$InventoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get customPrice => $composableBuilder(
    column: $table.customPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tranctionType => $composableBuilder(
    column: $table.tranctionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductTableOrderingComposer get productId {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableOrderingComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryTable> {
  $$InventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get customPrice => $composableBuilder(
    column: $table.customPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get tranctionType => $composableBuilder(
    column: $table.tranctionType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$ProductTableAnnotationComposer get productId {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableAnnotationComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryTable,
          InventoryData,
          $$InventoryTableFilterComposer,
          $$InventoryTableOrderingComposer,
          $$InventoryTableAnnotationComposer,
          $$InventoryTableCreateCompanionBuilder,
          $$InventoryTableUpdateCompanionBuilder,
          (InventoryData, $$InventoryTableReferences),
          InventoryData,
          PrefetchHooks Function({bool productId})
        > {
  $$InventoryTableTableManager(_$AppDatabase db, $InventoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<double?> customPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> tranctionType = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InventoryCompanion(
                id: id,
                productId: productId,
                customName: customName,
                customPrice: customPrice,
                quantity: quantity,
                tranctionType: tranctionType,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<double?> customPrice = const Value.absent(),
                required int quantity,
                required String tranctionType,
                Value<bool> isDeleted = const Value.absent(),
              }) => InventoryCompanion.insert(
                id: id,
                productId: productId,
                customName: customName,
                customPrice: customPrice,
                quantity: quantity,
                tranctionType: tranctionType,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InventoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$InventoryTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$InventoryTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryTable,
      InventoryData,
      $$InventoryTableFilterComposer,
      $$InventoryTableOrderingComposer,
      $$InventoryTableAnnotationComposer,
      $$InventoryTableCreateCompanionBuilder,
      $$InventoryTableUpdateCompanionBuilder,
      (InventoryData, $$InventoryTableReferences),
      InventoryData,
      PrefetchHooks Function({bool productId})
    >;
typedef $$TransactionMasterTableCreateCompanionBuilder =
    TransactionMasterCompanion Function({
      Value<int> id,
      required int customerId,
      required double totalAmount,
      Value<DateTime> createdAt,
      Value<bool> isDeleted,
    });
typedef $$TransactionMasterTableUpdateCompanionBuilder =
    TransactionMasterCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<double> totalAmount,
      Value<DateTime> createdAt,
      Value<bool> isDeleted,
    });

final class $$TransactionMasterTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionMasterTable,
          TransactionMasterData
        > {
  $$TransactionMasterTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomerTable _customerIdTable(_$AppDatabase db) =>
      db.customer.createAlias('transaction_master__customer_id__customer__id');

  $$CustomerTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomerTableTableManager(
      $_db,
      $_db.customer,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionItemTable, List<TransactionItemData>>
  _transactionItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactionItem,
    aliasName: 'transaction_master__id__transaction_item__transaction_id',
  );

  $$TransactionItemTableProcessedTableManager get transactionItemRefs {
    final manager = $$TransactionItemTableTableManager(
      $_db,
      $_db.transactionItem,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionItemRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionMasterTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionMasterTable> {
  $$TransactionMasterTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomerTableFilterComposer get customerId {
    final $$CustomerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customer,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerTableFilterComposer(
            $db: $db,
            $table: $db.customer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionItemRefs(
    Expression<bool> Function($$TransactionItemTableFilterComposer f) f,
  ) {
    final $$TransactionItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionItem,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionItemTableFilterComposer(
            $db: $db,
            $table: $db.transactionItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionMasterTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionMasterTable> {
  $$TransactionMasterTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomerTableOrderingComposer get customerId {
    final $$CustomerTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customer,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerTableOrderingComposer(
            $db: $db,
            $table: $db.customer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionMasterTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionMasterTable> {
  $$TransactionMasterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$CustomerTableAnnotationComposer get customerId {
    final $$CustomerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customer,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerTableAnnotationComposer(
            $db: $db,
            $table: $db.customer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionItemRefs<T extends Object>(
    Expression<T> Function($$TransactionItemTableAnnotationComposer a) f,
  ) {
    final $$TransactionItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionItem,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionItemTableAnnotationComposer(
            $db: $db,
            $table: $db.transactionItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionMasterTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionMasterTable,
          TransactionMasterData,
          $$TransactionMasterTableFilterComposer,
          $$TransactionMasterTableOrderingComposer,
          $$TransactionMasterTableAnnotationComposer,
          $$TransactionMasterTableCreateCompanionBuilder,
          $$TransactionMasterTableUpdateCompanionBuilder,
          (TransactionMasterData, $$TransactionMasterTableReferences),
          TransactionMasterData,
          PrefetchHooks Function({bool customerId, bool transactionItemRefs})
        > {
  $$TransactionMasterTableTableManager(
    _$AppDatabase db,
    $TransactionMasterTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionMasterTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionMasterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionMasterTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => TransactionMasterCompanion(
                id: id,
                customerId: customerId,
                totalAmount: totalAmount,
                createdAt: createdAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required double totalAmount,
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => TransactionMasterCompanion.insert(
                id: id,
                customerId: customerId,
                totalAmount: totalAmount,
                createdAt: createdAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionMasterTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({customerId = false, transactionItemRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionItemRefs) db.transactionItem,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$TransactionMasterTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$TransactionMasterTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionItemRefs)
                        await $_getPrefetchedData<
                          TransactionMasterData,
                          $TransactionMasterTable,
                          TransactionItemData
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionMasterTableReferences
                              ._transactionItemRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionMasterTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionItemRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionMasterTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionMasterTable,
      TransactionMasterData,
      $$TransactionMasterTableFilterComposer,
      $$TransactionMasterTableOrderingComposer,
      $$TransactionMasterTableAnnotationComposer,
      $$TransactionMasterTableCreateCompanionBuilder,
      $$TransactionMasterTableUpdateCompanionBuilder,
      (TransactionMasterData, $$TransactionMasterTableReferences),
      TransactionMasterData,
      PrefetchHooks Function({bool customerId, bool transactionItemRefs})
    >;
typedef $$TransactionItemTableCreateCompanionBuilder =
    TransactionItemCompanion Function({
      Value<int> id,
      required int transactionId,
      Value<int?> productId,
      required String productName,
      required double unitPrice,
      required int quantity,
      required String type,
      Value<bool> isDeleted,
    });
typedef $$TransactionItemTableUpdateCompanionBuilder =
    TransactionItemCompanion Function({
      Value<int> id,
      Value<int> transactionId,
      Value<int?> productId,
      Value<String> productName,
      Value<double> unitPrice,
      Value<int> quantity,
      Value<String> type,
      Value<bool> isDeleted,
    });

final class $$TransactionItemTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionItemTable,
          TransactionItemData
        > {
  $$TransactionItemTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionMasterTable _transactionIdTable(_$AppDatabase db) => db
      .transactionMaster
      .createAlias('transaction_item__transaction_id__transaction_master__id');

  $$TransactionMasterTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<int>('transaction_id')!;

    final manager = $$TransactionMasterTableTableManager(
      $_db,
      $_db.transactionMaster,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductTable _productIdTable(_$AppDatabase db) =>
      db.product.createAlias('transaction_item__product_id__product__id');

  $$ProductTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductTableTableManager(
      $_db,
      $_db.product,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionItemTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionItemTable> {
  $$TransactionItemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionMasterTableFilterComposer get transactionId {
    final $$TransactionMasterTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionMaster,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionMasterTableFilterComposer(
            $db: $db,
            $table: $db.transactionMaster,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTableFilterComposer get productId {
    final $$ProductTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableFilterComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionItemTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionItemTable> {
  $$TransactionItemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionMasterTableOrderingComposer get transactionId {
    final $$TransactionMasterTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionMaster,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionMasterTableOrderingComposer(
            $db: $db,
            $table: $db.transactionMaster,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTableOrderingComposer get productId {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableOrderingComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionItemTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionItemTable> {
  $$TransactionItemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$TransactionMasterTableAnnotationComposer get transactionId {
    final $$TransactionMasterTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionId,
          referencedTable: $db.transactionMaster,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionMasterTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionMaster,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ProductTableAnnotationComposer get productId {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableAnnotationComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionItemTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionItemTable,
          TransactionItemData,
          $$TransactionItemTableFilterComposer,
          $$TransactionItemTableOrderingComposer,
          $$TransactionItemTableAnnotationComposer,
          $$TransactionItemTableCreateCompanionBuilder,
          $$TransactionItemTableUpdateCompanionBuilder,
          (TransactionItemData, $$TransactionItemTableReferences),
          TransactionItemData,
          PrefetchHooks Function({bool transactionId, bool productId})
        > {
  $$TransactionItemTableTableManager(
    _$AppDatabase db,
    $TransactionItemTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionItemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> transactionId = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => TransactionItemCompanion(
                id: id,
                transactionId: transactionId,
                productId: productId,
                productName: productName,
                unitPrice: unitPrice,
                quantity: quantity,
                type: type,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int transactionId,
                Value<int?> productId = const Value.absent(),
                required String productName,
                required double unitPrice,
                required int quantity,
                required String type,
                Value<bool> isDeleted = const Value.absent(),
              }) => TransactionItemCompanion.insert(
                id: id,
                transactionId: transactionId,
                productId: productId,
                productName: productName,
                unitPrice: unitPrice,
                quantity: quantity,
                type: type,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionItemTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (transactionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.transactionId,
                                referencedTable:
                                    $$TransactionItemTableReferences
                                        ._transactionIdTable(db),
                                referencedColumn:
                                    $$TransactionItemTableReferences
                                        ._transactionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$TransactionItemTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$TransactionItemTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionItemTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionItemTable,
      TransactionItemData,
      $$TransactionItemTableFilterComposer,
      $$TransactionItemTableOrderingComposer,
      $$TransactionItemTableAnnotationComposer,
      $$TransactionItemTableCreateCompanionBuilder,
      $$TransactionItemTableUpdateCompanionBuilder,
      (TransactionItemData, $$TransactionItemTableReferences),
      TransactionItemData,
      PrefetchHooks Function({bool transactionId, bool productId})
    >;
typedef $$CustomerLedgerTableCreateCompanionBuilder =
    CustomerLedgerCompanion Function({
      Value<int> id,
      required int customerId,
      Value<int?> productId,
      required String transactionType,
      Value<int?> quantity,
      Value<double?> unitPrice,
      Value<double> creditAmount,
      Value<double> debitAmount,
      Value<double> paymentAmount,
      required double balance,
      Value<DateTime> createdAt,
    });
typedef $$CustomerLedgerTableUpdateCompanionBuilder =
    CustomerLedgerCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<int?> productId,
      Value<String> transactionType,
      Value<int?> quantity,
      Value<double?> unitPrice,
      Value<double> creditAmount,
      Value<double> debitAmount,
      Value<double> paymentAmount,
      Value<double> balance,
      Value<DateTime> createdAt,
    });

final class $$CustomerLedgerTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CustomerLedgerTable,
          CustomerLedgerData
        > {
  $$CustomerLedgerTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomerTable _customerIdTable(_$AppDatabase db) =>
      db.customer.createAlias('customer_ledger__customer_id__customer__id');

  $$CustomerTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomerTableTableManager(
      $_db,
      $_db.customer,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductTable _productIdTable(_$AppDatabase db) =>
      db.product.createAlias('customer_ledger__product_id__product__id');

  $$ProductTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductTableTableManager(
      $_db,
      $_db.product,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CustomerLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerLedgerTable> {
  $$CustomerLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditAmount => $composableBuilder(
    column: $table.creditAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get debitAmount => $composableBuilder(
    column: $table.debitAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomerTableFilterComposer get customerId {
    final $$CustomerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customer,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerTableFilterComposer(
            $db: $db,
            $table: $db.customer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTableFilterComposer get productId {
    final $$ProductTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableFilterComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerLedgerTable> {
  $$CustomerLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditAmount => $composableBuilder(
    column: $table.creditAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get debitAmount => $composableBuilder(
    column: $table.debitAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomerTableOrderingComposer get customerId {
    final $$CustomerTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customer,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerTableOrderingComposer(
            $db: $db,
            $table: $db.customer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTableOrderingComposer get productId {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableOrderingComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerLedgerTable> {
  $$CustomerLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get creditAmount => $composableBuilder(
    column: $table.creditAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get debitAmount => $composableBuilder(
    column: $table.debitAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomerTableAnnotationComposer get customerId {
    final $$CustomerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customer,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerTableAnnotationComposer(
            $db: $db,
            $table: $db.customer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTableAnnotationComposer get productId {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.product,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTableAnnotationComposer(
            $db: $db,
            $table: $db.product,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerLedgerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerLedgerTable,
          CustomerLedgerData,
          $$CustomerLedgerTableFilterComposer,
          $$CustomerLedgerTableOrderingComposer,
          $$CustomerLedgerTableAnnotationComposer,
          $$CustomerLedgerTableCreateCompanionBuilder,
          $$CustomerLedgerTableUpdateCompanionBuilder,
          (CustomerLedgerData, $$CustomerLedgerTableReferences),
          CustomerLedgerData,
          PrefetchHooks Function({bool customerId, bool productId})
        > {
  $$CustomerLedgerTableTableManager(
    _$AppDatabase db,
    $CustomerLedgerTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<int?> quantity = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double> creditAmount = const Value.absent(),
                Value<double> debitAmount = const Value.absent(),
                Value<double> paymentAmount = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerLedgerCompanion(
                id: id,
                customerId: customerId,
                productId: productId,
                transactionType: transactionType,
                quantity: quantity,
                unitPrice: unitPrice,
                creditAmount: creditAmount,
                debitAmount: debitAmount,
                paymentAmount: paymentAmount,
                balance: balance,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                Value<int?> productId = const Value.absent(),
                required String transactionType,
                Value<int?> quantity = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double> creditAmount = const Value.absent(),
                Value<double> debitAmount = const Value.absent(),
                Value<double> paymentAmount = const Value.absent(),
                required double balance,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerLedgerCompanion.insert(
                id: id,
                customerId: customerId,
                productId: productId,
                transactionType: transactionType,
                quantity: quantity,
                unitPrice: unitPrice,
                creditAmount: creditAmount,
                debitAmount: debitAmount,
                paymentAmount: paymentAmount,
                balance: balance,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomerLedgerTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({customerId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$CustomerLedgerTableReferences
                                    ._customerIdTable(db),
                                referencedColumn:
                                    $$CustomerLedgerTableReferences
                                        ._customerIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$CustomerLedgerTableReferences
                                    ._productIdTable(db),
                                referencedColumn:
                                    $$CustomerLedgerTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CustomerLedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerLedgerTable,
      CustomerLedgerData,
      $$CustomerLedgerTableFilterComposer,
      $$CustomerLedgerTableOrderingComposer,
      $$CustomerLedgerTableAnnotationComposer,
      $$CustomerLedgerTableCreateCompanionBuilder,
      $$CustomerLedgerTableUpdateCompanionBuilder,
      (CustomerLedgerData, $$CustomerLedgerTableReferences),
      CustomerLedgerData,
      PrefetchHooks Function({bool customerId, bool productId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductTableTableManager get product =>
      $$ProductTableTableManager(_db, _db.product);
  $$CustomerTableTableManager get customer =>
      $$CustomerTableTableManager(_db, _db.customer);
  $$InventoryTableTableManager get inventory =>
      $$InventoryTableTableManager(_db, _db.inventory);
  $$TransactionMasterTableTableManager get transactionMaster =>
      $$TransactionMasterTableTableManager(_db, _db.transactionMaster);
  $$TransactionItemTableTableManager get transactionItem =>
      $$TransactionItemTableTableManager(_db, _db.transactionItem);
  $$CustomerLedgerTableTableManager get customerLedger =>
      $$CustomerLedgerTableTableManager(_db, _db.customerLedger);
}
