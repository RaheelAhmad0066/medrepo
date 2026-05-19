import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medrep_pro/core/di/dependency_providers.dart';
import 'package:medrep_pro/features/products/data/datasources/product_remote_datasource.dart';
import 'package:medrep_pro/features/products/data/datasources/product_local_datasource.dart';
import 'package:medrep_pro/features/products/data/repositories/product_repository_impl.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/domain/repositories/product_repository.dart';

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return ProductRemoteDataSource(dio);
});

final productLocalDataSourceProvider = Provider<ProductLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProductLocalDataSource(db);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remote = ref.watch(productRemoteDataSourceProvider);
  final local = ref.watch(productLocalDataSourceProvider);
  final conn = ref.watch(connectivityProvider);
  final db = ref.watch(appDatabaseProvider);
  return ProductRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
    connectivityService: conn,
    db: db,
  );
});

class ProductListState {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final int page;
  final bool hasReachedMax;
  final String searchQuery;
  final String? selectedCategory;
  final bool? isDiscontinued;

  ProductListState({
    required this.products,
    required this.isLoading,
    this.error,
    required this.page,
    required this.hasReachedMax,
    required this.searchQuery,
    this.selectedCategory,
    this.isDiscontinued,
  });

  factory ProductListState.initial() => ProductListState(
        products: [],
        isLoading: false,
        page: 1,
        hasReachedMax: false,
        searchQuery: '',
      );

  ProductListState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
    int? page,
    bool? hasReachedMax,
    String? searchQuery,
    String? selectedCategory,
    bool clearCategory = false,
    bool? isDiscontinued,
    bool clearDiscontinued = false,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      isDiscontinued: clearDiscontinued ? null : (isDiscontinued ?? this.isDiscontinued),
    );
  }
}

class ProductListNotifier extends StateNotifier<ProductListState> {
  final ProductRepository _repository;

  ProductListNotifier(this._repository) : super(ProductListState.initial()) {
    fetchProducts();
  }

  Future<void> fetchProducts({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (forceRefresh) {
      state = state.copyWith(page: 1, hasReachedMax: false, products: []);
    }

    if (state.hasReachedMax) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getProducts(
      page: state.page,
      limit: 15,
      searchQuery: state.searchQuery,
      category: state.selectedCategory,
      isDiscontinued: state.isDiscontinued,
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (newProducts) {
        state = state.copyWith(
          isLoading: false,
          products: [...state.products, ...newProducts],
          page: state.page + 1,
          hasReachedMax: newProducts.length < 15,
        );
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
    );
  }

  void setSearchQuery(String query) {
    if (state.searchQuery == query) return;
    state = state.copyWith(searchQuery: query);
    fetchProducts(forceRefresh: true);
  }

  void setCategoryFilter(String? category) {
    if (state.selectedCategory == category) return;
    if (category == null) {
      state = state.copyWith(clearCategory: true);
    } else {
      state = state.copyWith(selectedCategory: category);
    }
    fetchProducts(forceRefresh: true);
  }

  void setDiscontinuedFilter(bool? isDiscontinued) {
    if (state.isDiscontinued == isDiscontinued) return;
    if (isDiscontinued == null) {
      state = state.copyWith(clearDiscontinued: true);
    } else {
      state = state.copyWith(isDiscontinued: isDiscontinued);
    }
    fetchProducts(forceRefresh: true);
  }

  Future<void> addProduct(Product product) async {
    final result = await _repository.addProduct(product);
    result.when(
      onSuccess: (newProduct) {
        state = state.copyWith(
          products: [newProduct, ...state.products],
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> updateProduct(Product product) async {
    final result = await _repository.updateProduct(product);
    result.when(
      onSuccess: (updatedProduct) {
        state = state.copyWith(
          products: state.products.map((e) => e.id == updatedProduct.id ? updatedProduct : e).toList(),
        );
      },
      onFailure: (_) {},
    );
  }

  Future<void> deleteProduct(String id) async {
    final result = await _repository.deleteProduct(id);
    result.when(
      onSuccess: (_) {
        state = state.copyWith(
          products: state.products.where((e) => e.id != id).toList(),
        );
      },
      onFailure: (_) {},
    );
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier, ProductListState>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return ProductListNotifier(repo);
});

final priceHistoryProvider = FutureProvider.family<List<PriceHistoryEntry>, String>((ref, productId) async {
  final repo = ref.watch(productRepositoryProvider);
  final result = await repo.getPriceHistory(productId);
  return result.when(
    onSuccess: (history) => history,
    onFailure: (_) => [],
  );
});
