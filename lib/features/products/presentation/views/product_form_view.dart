import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';
import 'package:medrep_pro/features/products/presentation/providers/product_providers.dart';

class ProductFormView extends ConsumerStatefulWidget {
  final Product? product;

  const ProductFormView({super.key, this.product});

  @override
  ConsumerState<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends ConsumerState<ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _category;
  late String _sku;
  late double _price;
  late bool _isDiscontinued;
  late bool _isSampleEligible;

  @override
  void initState() {
    super.initState();
    final prod = widget.product;
    _name = prod?.name ?? '';
    _category = prod?.category ?? 'Cardiology';
    _sku = prod?.sku ?? '';
    _price = prod?.price ?? 0.0;
    _isDiscontinued = prod?.isDiscontinued ?? false;
    _isSampleEligible = prod?.isSampleEligible ?? true;
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final tenantId = ref.read(clerkAuthProvider).client.user?.publicMetadata?['tenant_id'] as String? ?? 'demo_tenant';
    final isEdit = widget.product != null;

    final product = Product(
      id: widget.product?.id ?? const Uuid().v4(),
      tenantId: widget.product?.tenantId ?? tenantId,
      name: _name,
      category: _category,
      sku: _sku,
      price: _price,
      isDiscontinued: _isDiscontinued,
      isSampleEligible: _isSampleEligible,
      clientCreatedAt: widget.product?.clientCreatedAt ?? DateTime.now(),
      lastModifiedAt: DateTime.now(),
      isDeleted: false,
    );

    if (isEdit) {
      await ref.read(productListProvider.notifier).updateProduct(product);
    } else {
      await ref.read(productListProvider.notifier).addProduct(product);
      // Add initial price history entry
      final entry = PriceHistoryEntry(
        id: const Uuid().v4(),
        productId: product.id,
        price: _price,
        effectiveFrom: DateTime.now(),
      );
      await ref.read(productRepositoryProvider).addPriceHistoryEntry(entry);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isEdit ? 'Product updated successfully!' : 'Product registered successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;
    final categories = ['Cardiology', 'Neurology', 'Oncology', 'Pediatrics', 'Antibiotics'];

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Product' : 'Register New Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                labelText: 'Product Name *',
                prefixIcon: Icon(Icons.shopping_bag),
              ),
              validator: (val) => val == null || val.trim().isEmpty ? 'Please enter product name' : null,
              onSaved: (val) => _name = val!.trim(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _sku,
              decoration: const InputDecoration(
                labelText: 'SKU / Product Code *',
                prefixIcon: Icon(Icons.qr_code),
              ),
              validator: (val) => val == null || val.trim().isEmpty ? 'Please enter SKU' : null,
              onSaved: (val) => _sku = val!.trim(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: 'Category *',
                prefixIcon: Icon(Icons.category),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _category = val;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _price.toString(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Unit Price (\$)*',
                prefixIcon: Icon(Icons.attach_money),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Please enter price';
                final num = double.tryParse(val.trim());
                if (num == null || num <= 0) return 'Please enter a valid positive number';
                return null;
              },
              onSaved: (val) => _price = double.parse(val!.trim()),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Sample Eligible'),
              subtitle: const Text('Allow reps to distribute this product as samples'),
              value: _isSampleEligible,
              onChanged: (val) {
                setState(() {
                  _isSampleEligible = val;
                });
              },
            ),
            if (isEdit) ...[
              SwitchListTile(
                title: const Text('Discontinued'),
                subtitle: const Text('Mark this product as discontinued'),
                value: _isDiscontinued,
                onChanged: (val) {
                  setState(() {
                    _isDiscontinued = val;
                  });
                },
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isEdit ? 'Save Changes' : 'Register Product',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
