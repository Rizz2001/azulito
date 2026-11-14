import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// -------------------------------------------------------------
// TABLA LOCAL: SYNC QUEUE (Motor Híbrido Anti-Apagones)
// -------------------------------------------------------------
class SyncQueue extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get targetTable => text()(); // 'sales', 'products', etc.
  TextColumn get entityId => text()(); // UUID de la fila
  TextColumn get operation => text()(); // 'INSERT', 'UPDATE', 'DELETE'
  TextColumn get payload => text()(); // JSON serializado
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, processing, failed
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// -------------------------------------------------------------
// TABLAS ESPEJO SUPABASE (14 TABLAS RELACIONALES)
// -------------------------------------------------------------

class Stores extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get rif => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get primaryColor => text().withDefault(const Constant('#1E40AF'))();
  TextColumn get secondaryColor => text().withDefault(const Constant('#0EA5E9'))();
  BoolColumn get defaultIgtfEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ExchangeRates extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get source => text()(); // 'bcv', 'parallel', 'manual'
  RealColumn get rate => real()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get fullName => text()();
  TextColumn get email => text().nullable()();
  TextColumn get role => text().withDefault(const Constant('cashier'))(); // 'admin', 'cashier'
  TextColumn get quickPin => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get name => text()();
  TextColumn get iconName => text().withDefault(const Constant('category'))();
  TextColumn get colorHex => text().withDefault(const Constant('#0EA5E9'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Products extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get sku => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get productType => text().withDefault(const Constant('unit'))(); // 'unit', 'weight_fraction', 'variant', 'combo'
  RealColumn get costUsd => real().withDefault(const Constant(0.0))();
  RealColumn get profitMarginPercent => real().withDefault(const Constant(30.0))();
  RealColumn get priceUsd => real()();
  RealColumn get stockQuantity => real().withDefault(const Constant(0.0))();
  RealColumn get minStockAlert => real().withDefault(const Constant(5.0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductPresentations extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(Products, #id)();
  TextColumn get name => text()();
  TextColumn get barcode => text().nullable()();
  RealColumn get quantityEquivalent => real()();
  RealColumn get priceUsd => real()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductVariants extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(Products, #id)();
  TextColumn get variantName => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get barcode => text().nullable()();
  RealColumn get additionalPriceUsd => real().withDefault(const Constant(0.0))();
  RealColumn get stockQuantity => real().withDefault(const Constant(0.0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ComboItems extends Table {
  TextColumn get id => text()();
  TextColumn get comboProductId => text().references(Products, #id)();
  TextColumn get componentProductId => text().references(Products, #id)();
  RealColumn get quantityRequired => real().withDefault(const Constant(1.0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get fullName => text()();
  TextColumn get idDocument => text().nullable()(); // Cédula o RIF
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  RealColumn get creditLimitUsd => real().withDefault(const Constant(0.0))();
  RealColumn get currentDebtUsd => real().withDefault(const Constant(0.0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class CashSessions extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get userId => text().nullable().references(Profiles, #id)();
  TextColumn get status => text().withDefault(const Constant('open'))(); // 'open', 'closed'
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closedAt => dateTime().nullable()();
  RealColumn get openingCashUsd => real().withDefault(const Constant(0.0))();
  RealColumn get openingCashBs => real().withDefault(const Constant(0.0))();
  RealColumn get expectedCashUsd => real().withDefault(const Constant(0.0))();
  RealColumn get expectedCashBs => real().withDefault(const Constant(0.0))();
  RealColumn get declaredCashUsd => real().nullable()();
  RealColumn get declaredCashBs => real().nullable()();
  RealColumn get differenceUsd => real().nullable()();
  RealColumn get differenceBs => real().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Sales extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get cashSessionId => text().nullable().references(CashSessions, #id)();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  TextColumn get userId => text().nullable().references(Profiles, #id)();
  TextColumn get invoiceNumber => text()();
  RealColumn get exchangeRateUsed => real()();
  RealColumn get subtotalUsd => real()();
  RealColumn get discountUsd => real().withDefault(const Constant(0.0))();
  BoolColumn get igtfApplied => boolean().withDefault(const Constant(false))();
  RealColumn get igtfAmountUsd => real().withDefault(const Constant(0.0))();
  RealColumn get totalUsd => real()();
  RealColumn get totalBs => real()();
  TextColumn get paymentStatus => text().withDefault(const Constant('paid'))(); // 'paid', 'partial', 'pending', 'cancelled'
  TextColumn get notes => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class SaleItems extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text().references(Sales, #id)();
  TextColumn get productId => text().references(Products, #id)();
  TextColumn get presentationId => text().nullable().references(ProductPresentations, #id)();
  TextColumn get variantId => text().nullable().references(ProductVariants, #id)();
  TextColumn get productName => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPriceUsd => real()();
  RealColumn get subtotalUsd => real()();
  RealColumn get returnedQuantity => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class SalePayments extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text().references(Sales, #id)();
  TextColumn get paymentMethod => text()(); // 'cash_usd', 'pago_movil', etc.
  RealColumn get amountOriginal => real()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  RealColumn get exchangeRate => real()();
  RealColumn get amountUsdEquivalent => real()();
  TextColumn get referenceNumber => text().nullable()();
  TextColumn get bankName => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryMovements extends Table {
  TextColumn get id => text()();
  TextColumn get storeId => text().nullable().references(Stores, #id)();
  TextColumn get productId => text().references(Products, #id)();
  TextColumn get movementType => text()(); // 'initial', 'purchase', 'sale', 'refund', 'adjustment', 'waste'
  RealColumn get quantity => real()();
  RealColumn get previousStock => real()();
  RealColumn get newStock => real()();
  RealColumn get costUsd => real().nullable()();
  TextColumn get referenceId => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// -------------------------------------------------------------
// BASE DE DATOS DRIFT MULTIPLATAFORMA (Web / Windows / Android)
// -------------------------------------------------------------
@DriftDatabase(tables: [
  SyncQueue,
  Stores,
  ExchangeRates,
  Profiles,
  Categories,
  Products,
  ProductPresentations,
  ProductVariants,
  ComboItems,
  Customers,
  CashSessions,
  Sales,
  SaleItems,
  SalePayments,
  InventoryMovements,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // driftDatabase de drift_flutter maneja automáticamente SQLite nativo en
    // Windows/Android y WasmDatabase / IndexedDB en Flutter Web
    return driftDatabase(name: 'azulito_pos');
  }
}

