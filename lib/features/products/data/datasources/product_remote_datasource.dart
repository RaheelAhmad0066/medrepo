import 'package:medrep_pro/core/network/dio_client.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/data/models/product_dto.dart';

class ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSource(this._dioClient);

  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 15,
    String? searchQuery,
    String? category,
    bool? isDiscontinued,
    String? lastModifiedAfter,
  }) async {
    final Map<String, dynamic> params = {
      'page': page,
      'limit': limit,
    };
    if (searchQuery != null && searchQuery.isNotEmpty) {
      params['search'] = searchQuery;
    }
    if (category != null && category.isNotEmpty) {
      params['category'] = category;
    }
    if (isDiscontinued != null) {
      params['is_discontinued'] = isDiscontinued;
    }
    if (lastModifiedAfter != null) {
      params['modified_after'] = lastModifiedAfter;
    }

    final response = await _dioClient.get('/products', queryParameters: params);
    final data = response.data;
    if (data is List) {
      return data.map((json) => ProductDto.fromJson(json as Map<String, dynamic>)).toList();
    } else if (data is Map && data['data'] is List) {
      return (data['data'] as List).map((json) => ProductDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<Product> addProduct(Product product) async {
    final response = await _dioClient.post('/products', data: ProductDto.toJson(product));
    return ProductDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Product> updateProduct(Product product) async {
    final response = await _dioClient.put('/products', data: ProductDto.toJson(product));
    return ProductDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteProduct(String id) async {
    await _dioClient.delete('/products', data: {'id': id});
  }

  Future<List<PriceHistoryEntry>> getPriceHistory(String productId) async {
    final response = await _dioClient.get('/products/price-history', queryParameters: {'product_id': productId});
    final data = response.data;
    if (data is List) {
      return data.map((json) => PriceHistoryDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<PriceHistoryEntry> addPriceHistoryEntry(PriceHistoryEntry entry) async {
    final response = await _dioClient.post('/products/price-history', data: PriceHistoryDto.toJson(entry));
    return PriceHistoryDto.fromJson(response.data as Map<String, dynamic>);
  }
}
