import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/data/models/product_dto.dart';

class ProductLocalDataSource {
  final AppDatabase _db;

  ProductLocalDataSource(this._db);

  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 15,
    String? searchQuery,
    String? category,
    bool? isDiscontinued,
  }) async {
    final query = _db.select(_db.productsTable)
      ..where((t) => t.isDeleted.equals(false));

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where((t) => t.name.like('%$searchQuery%') | t.sku.like('%$searchQuery%'));
    }

    if (category != null && category.isNotEmpty) {
      query.where((t) => t.category.equals(category));
    }

    if (isDiscontinued != null) {
      query.where((t) => t.isDiscontinued.equals(isDiscontinued));
    }

    query.limit(limit, offset: (page - 1) * limit);

    final results = await query.get();
    return results.map((row) => ProductDto.fromDb(row)).toList();
  }

  Future<void> saveProducts(List<Product> products) async {
    await _db.batch((batch) {
      for (final prod in products) {
        batch.insert(
          _db.productsTable,
          ProductDto.toDbCompanion(prod),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> saveProduct(Product product) async {
    await _db.into(_db.productsTable).insertOnConflictUpdate(ProductDto.toDbCompanion(product));
  }

  Future<Product?> getProductById(String id) async {
    final query = _db.select(_db.productsTable)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row != null) {
      return ProductDto.fromDb(row);
    }
    return null;
  }

  Future<void> softDeleteProduct(String id) async {
    await (_db.update(_db.productsTable)..where((t) => t.id.equals(id))).write(
      const ProductsTableCompanion(
        isDeleted: Value(true),
        lastModifiedAt: Value.absent(),
      ),
    );
  }

  Future<List<PriceHistoryEntry>> getPriceHistory(String productId) async {
    final query = _db.select(_db.priceHistoryTable)
      ..where((t) => t.productId.equals(productId))
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)]);
    final results = await query.get();
    return results.map((row) => PriceHistoryDto.fromDb(row)).toList();
  }

  Future<void> savePriceHistoryEntries(List<PriceHistoryEntry> entries) async {
    await _db.batch((batch) {
      for (final entry in entries) {
        batch.insert(
          _db.priceHistoryTable,
          PriceHistoryDto.toDbCompanion(entry),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> savePriceHistoryEntry(PriceHistoryEntry entry) async {
    await _db.into(_db.priceHistoryTable).insertOnConflictUpdate(PriceHistoryDto.toDbCompanion(entry));
  }
}
