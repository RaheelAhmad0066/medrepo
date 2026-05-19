import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';

class ProductDto {
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      sku: json['sku'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      pdfVisualAidUrl: json['pdf_visual_aid_url'] as String?,
      isDiscontinued: json['is_discontinued'] as bool? ?? false,
      isSampleEligible: json['is_sample_eligible'] as bool? ?? true,
      clientCreatedAt: DateTime.parse(json['client_created_at'] as String),
      lastModifiedAt: DateTime.parse(json['last_modified_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toJson(Product product) {
    return {
      'id': product.id,
      'tenant_id': product.tenantId,
      'name': product.name,
      'category': product.category,
      'sku': product.sku,
      'price': product.price,
      'image_url': product.imageUrl,
      'pdf_visual_aid_url': product.pdfVisualAidUrl,
      'is_discontinued': product.isDiscontinued,
      'is_sample_eligible': product.isSampleEligible,
      'client_created_at': product.clientCreatedAt.toIso8601String(),
      'last_modified_at': product.lastModifiedAt.toIso8601String(),
      'is_deleted': product.isDeleted,
    };
  }

  static Product fromDb(ProductsTableData dbData) {
    return Product(
      id: dbData.id,
      tenantId: dbData.tenantId,
      name: dbData.name,
      category: dbData.category,
      sku: dbData.sku,
      price: dbData.price,
      imageUrl: dbData.imageUrl,
      pdfVisualAidUrl: dbData.pdfVisualAidUrl,
      isDiscontinued: dbData.isDiscontinued,
      isSampleEligible: dbData.isSampleEligible,
      clientCreatedAt: dbData.clientCreatedAt,
      lastModifiedAt: dbData.lastModifiedAt,
      isDeleted: dbData.isDeleted,
    );
  }

  static ProductsTableCompanion toDbCompanion(Product product) {
    return ProductsTableCompanion(
      id: Value(product.id),
      tenantId: Value(product.tenantId),
      name: Value(product.name),
      category: Value(product.category),
      sku: Value(product.sku),
      price: Value(product.price),
      imageUrl: Value(product.imageUrl),
      pdfVisualAidUrl: Value(product.pdfVisualAidUrl),
      isDiscontinued: Value(product.isDiscontinued),
      isSampleEligible: Value(product.isSampleEligible),
      clientCreatedAt: Value(product.clientCreatedAt),
      lastModifiedAt: Value(product.lastModifiedAt),
      isDeleted: Value(product.isDeleted),
    );
  }
}

class PriceHistoryDto {
  static PriceHistoryEntry fromJson(Map<String, dynamic> json) {
    return PriceHistoryEntry(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      price: (json['price'] as num).toDouble(),
      effectiveFrom: DateTime.parse(json['effective_from'] as String),
    );
  }

  static Map<String, dynamic> toJson(PriceHistoryEntry entry) {
    return {
      'id': entry.id,
      'product_id': entry.productId,
      'price': entry.price,
      'effective_from': entry.effectiveFrom.toIso8601String(),
    };
  }

  static PriceHistoryEntry fromDb(PriceHistoryTableData dbData) {
    return PriceHistoryEntry(
      id: dbData.id,
      productId: dbData.productId,
      price: dbData.price,
      effectiveFrom: dbData.effectiveFrom,
    );
  }

  static PriceHistoryTableCompanion toDbCompanion(PriceHistoryEntry entry) {
    return PriceHistoryTableCompanion(
      id: Value(entry.id),
      productId: Value(entry.productId),
      price: Value(entry.price),
      effectiveFrom: Value(entry.effectiveFrom),
    );
  }
}
