import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String tenantId;
  final String name;
  final String category;
  final String sku;
  final double price;
  final String? imageUrl;
  final String? pdfVisualAidUrl;
  final bool isDiscontinued;
  final bool isSampleEligible;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;

  const Product({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.category,
    required this.sku,
    required this.price,
    this.imageUrl,
    this.pdfVisualAidUrl,
    this.isDiscontinued = false,
    this.isSampleEligible = true,
    required this.clientCreatedAt,
    required this.lastModifiedAt,
    this.isDeleted = false,
  });

  Product copyWith({
    String? id,
    String? tenantId,
    String? name,
    String? category,
    String? sku,
    double? price,
    String? imageUrl,
    String? pdfVisualAidUrl,
    bool? isDiscontinued,
    bool? isSampleEligible,
    DateTime? clientCreatedAt,
    DateTime? lastModifiedAt,
    bool? isDeleted,
  }) {
    return Product(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      category: category ?? this.category,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      pdfVisualAidUrl: pdfVisualAidUrl ?? this.pdfVisualAidUrl,
      isDiscontinued: isDiscontinued ?? this.isDiscontinued,
      isSampleEligible: isSampleEligible ?? this.isSampleEligible,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tenantId,
        name,
        category,
        sku,
        price,
        imageUrl,
        pdfVisualAidUrl,
        isDiscontinued,
        isSampleEligible,
        clientCreatedAt,
        lastModifiedAt,
        isDeleted,
      ];
}

class PriceHistoryEntry extends Equatable {
  final String id;
  final String productId;
  final double price;
  final DateTime effectiveFrom;

  const PriceHistoryEntry({
    required this.id,
    required this.productId,
    required this.price,
    required this.effectiveFrom,
  });

  @override
  List<Object?> get props => [id, productId, price, effectiveFrom];
}
