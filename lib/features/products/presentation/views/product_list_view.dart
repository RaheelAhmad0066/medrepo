import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/products/presentation/providers/product_providers.dart';

class ProductListView extends ConsumerStatefulWidget {
  const ProductListView({super.key});

  @override
  ConsumerState<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends ConsumerState<ProductListView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(productListProvider.notifier).fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);
    final auth = ref.watch(clerkAuthProvider);
    final userRole = auth.client.user?.publicMetadata?['role'] as String? ?? 'rep';
    final isAdmin = userRole == 'admin' || userRole == 'manager';
    final theme = Theme.of(context);

    final categories = ['Cardiology', 'Neurology', 'Oncology', 'Pediatrics', 'Antibiotics'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    ref.read(productListProvider.notifier).setSearchQuery(val);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search product by name or SKU...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(productListProvider.notifier).setSearchQuery('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text('All'),
                        selected: state.selectedCategory == null,
                        onSelected: (selected) {
                          if (selected) {
                            ref.read(productListProvider.notifier).setCategoryFilter(null);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ...categories.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: state.selectedCategory == cat,
                            onSelected: (selected) {
                              ref.read(productListProvider.notifier).setCategoryFilter(selected ? cat : null);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Active'),
                      selected: state.isDiscontinued == false || state.isDiscontinued == null,
                      onSelected: (selected) {
                        ref.read(productListProvider.notifier).setDiscontinuedFilter(selected ? false : null);
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Discontinued'),
                      selected: state.isDiscontinued == true,
                      onSelected: (selected) {
                        ref.read(productListProvider.notifier).setDiscontinuedFilter(selected ? true : null);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isAdmin)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade800),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Reps have read-only access. Modification is restricted to Admin.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(productListProvider.notifier).fetchProducts(forceRefresh: true),
              child: state.products.isEmpty && !state.isLoading
                  ? const Center(
                      child: Text('No products matching criteria.'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: state.products.length + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.products.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final prod = state.products[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.medication, color: Colors.teal, size: 30),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    prod.name,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (prod.isSampleEligible)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.shade50,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.purple.shade100),
                                    ),
                                    child: Text(
                                      'Sample',
                                      style: TextStyle(fontSize: 10, color: Colors.purple.shade700, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text('SKU: ${prod.sku} • \$${prod.price.toStringAsFixed(2)}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              context.push('/product-detail', extra: prod);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                context.push('/product-form');
              },
              tooltip: 'Add Product',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
