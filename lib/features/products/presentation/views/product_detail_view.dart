import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/presentation/providers/product_providers.dart';

class ProductDetailView extends ConsumerWidget {
  final Product product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final auth = ref.watch(clerkAuthProvider);
    final userRole = auth.client.user?.publicMetadata?['role'] as String? ?? 'rep';
    final isAdmin = userRole == 'admin' || userRole == 'manager';

    final priceHistoryAsync = ref.watch(priceHistoryProvider(product.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.push('/product-form', extra: product);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Product'),
                    content: const Text('Are you sure you want to discontinue / delete this product?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(productListProvider.notifier).deleteProduct(product.id);
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.teal.shade100,
                      child: const Icon(Icons.medication, size: 40, color: Colors.teal),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'SKU: ${product.sku}',
                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Chip(
                                label: Text(product.category),
                                backgroundColor: Colors.teal.shade50,
                                labelStyle: const TextStyle(color: Colors.teal),
                              ),
                              const SizedBox(width: 8),
                              if (product.isDiscontinued)
                                Chip(
                                  label: const Text('Discontinued'),
                                  backgroundColor: Colors.red.shade50,
                                  labelStyle: TextStyle(color: Colors.red.shade700),
                                )
                              else
                                Chip(
                                  label: const Text('Active'),
                                  backgroundColor: Colors.green.shade50,
                                  labelStyle: TextStyle(color: Colors.green.shade700),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('View Visual Aid Slides'),
                    onPressed: () {
                      context.push('/product-pdf', extra: product);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Sample Distribution Rules',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(
                product.isSampleEligible ? Icons.check_circle : Icons.cancel,
                color: product.isSampleEligible ? Colors.green : Colors.red,
              ),
              title: const Text('Sample Distribution Eligibility'),
              subtitle: Text(product.isSampleEligible
                  ? 'Eligible for sample allocation during physician check-ins.'
                  : 'Restricted from distribution.'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pricing & Version History',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (isAdmin)
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Update Price'),
                    onPressed: () => _showUpdatePriceDialog(context, ref),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            priceHistoryAsync.when(
              data: (history) {
                if (history.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Center(
                      child: Text(
                        'Current standard price: \$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final entry = history[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.history_toggle_off, color: Colors.blueGrey),
                        title: Text('\$${entry.price.toStringAsFixed(2)}'),
                        subtitle: Text(
                          'Effective: ${entry.effectiveFrom.toLocal().toString().split(' ')[0]}',
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading price history: $err'),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdatePriceDialog(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    double newPrice = product.price;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Product Price'),
        content: Form(
          key: formKey,
          child: TextFormField(
            initialValue: product.price.toString(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'New Unit Price (\$)',
              prefixIcon: Icon(Icons.attach_money),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Please enter a price';
              final num = double.tryParse(val.trim());
              if (num == null || num <= 0) return 'Please enter a valid positive number';
              return null;
            },
            onSaved: (val) => newPrice = double.parse(val!.trim()),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();

              final updatedProduct = product.copyWith(
                price: newPrice,
                lastModifiedAt: DateTime.now(),
              );

              final entry = PriceHistoryEntry(
                id: const Uuid().v4(),
                productId: product.id,
                price: newPrice,
                effectiveFrom: DateTime.now(),
              );

              await ref.read(productRepositoryProvider).addPriceHistoryEntry(entry);
              await ref.read(productListProvider.notifier).updateProduct(updatedProduct);

              // Refresh list & price history
              ref.invalidate(priceHistoryProvider(product.id));

              Navigator.pop(ctx);
              Navigator.pop(context); // Pop back to catalog to show refresh
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
