import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<ApiResult<List<Product>>> getProducts({
    int page = 1,
    int limit = 15,
    String? searchQuery,
    String? category,
    bool? isDiscontinued,
    bool forceRefresh = false,
  });

  Future<ApiResult<Product>> addProduct(Product product);
  Future<ApiResult<Product>> updateProduct(Product product);
  Future<ApiResult<void>> deleteProduct(String id);
  Future<ApiResult<List<PriceHistoryEntry>>> getPriceHistory(String productId);
  Future<ApiResult<PriceHistoryEntry>> addPriceHistoryEntry(PriceHistoryEntry entry);
}
