import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:medrep_pro/core/di/clerk_auth_provider.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';
import 'package:medrep_pro/features/chemists/presentation/providers/chemist_providers.dart';

class ChemistFormView extends ConsumerStatefulWidget {
  final Chemist? chemist;

  const ChemistFormView({super.key, this.chemist});

  @override
  ConsumerState<ChemistFormView> createState() => _ChemistFormViewState();
}

class _ChemistFormViewState extends ConsumerState<ChemistFormView> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  String? _contactPerson;
  String? _phone;
  late String _address;
  late String _priorityTag;
  late double _outstandingBalance;
  late double _creditLimit;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    final chem = widget.chemist;
    _name = chem?.name ?? '';
    _contactPerson = chem?.contactPerson;
    _phone = chem?.phone;
    _address = chem?.address ?? '';
    _priorityTag = chem?.priorityTag ?? 'Medium';
    _outstandingBalance = chem?.outstandingBalance ?? 0.0;
    _creditLimit = chem?.creditLimit ?? 5000.0;
    _latitude = chem?.latitude;
    _longitude = chem?.longitude;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final tenantId = ref.read(clerkAuthProvider).client.user?.publicMetadata?['tenant_id'] as String? ?? 'demo_tenant';
    final isEdit = widget.chemist != null;

    final chemist = Chemist(
      id: widget.chemist?.id ?? const Uuid().v4(),
      tenantId: widget.chemist?.tenantId ?? tenantId,
      name: _name,
      contactPerson: _contactPerson,
      phone: _phone,
      address: _address,
      latitude: _latitude,
      longitude: _longitude,
      priorityTag: _priorityTag,
      outstandingBalance: _outstandingBalance,
      creditLimit: _creditLimit,
      clientCreatedAt: widget.chemist?.clientCreatedAt ?? DateTime.now(),
      lastModifiedAt: DateTime.now(),
      isDeleted: false,
    );

    if (isEdit) {
      ref.read(chemistListProvider.notifier).updateChemist(chemist);
    } else {
      ref.read(chemistListProvider.notifier).addChemist(chemist);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isEdit ? 'Chemist updated successfully!' : 'Chemist registered successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.chemist != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Pharmacy Profile' : 'Register New Pharmacy'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                labelText: 'Pharmacy / Store Name *',
                prefixIcon: Icon(Icons.store),
              ),
              validator: (val) => val == null || val.trim().isEmpty ? 'Please enter store name' : null,
              onSaved: (val) => _name = val!.trim(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _contactPerson,
              decoration: const InputDecoration(
                labelText: 'Contact Person / Owner',
                prefixIcon: Icon(Icons.person),
              ),
              onSaved: (val) => _contactPerson = val != null && val.trim().isNotEmpty ? val.trim() : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Store Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              onSaved: (val) => _phone = val != null && val.trim().isNotEmpty ? val.trim() : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _address,
              decoration: const InputDecoration(
                labelText: 'Store Address *',
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (val) => val == null || val.trim().isEmpty ? 'Please enter store address' : null,
              onSaved: (val) => _address = val!.trim(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _priorityTag,
              decoration: const InputDecoration(
                labelText: 'Priority Tag',
                prefixIcon: Icon(Icons.priority_high),
              ),
              items: ['High', 'Medium', 'Low'].map((prio) {
                return DropdownMenuItem(
                  value: prio,
                  child: Text(prio),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _priorityTag = val;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _outstandingBalance.toString(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Outstanding Balance (\$)',
                prefixIcon: Icon(Icons.money_off),
              ),
              validator: (val) {
                if (val != null && val.trim().isNotEmpty) {
                  final num = double.tryParse(val.trim());
                  if (num == null) return 'Please enter a valid amount';
                }
                return null;
              },
              onSaved: (val) => _outstandingBalance = val != null && val.trim().isNotEmpty ? double.parse(val.trim()) : 0.0,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _creditLimit.toString(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Credit Limit (\$)',
                prefixIcon: Icon(Icons.credit_card),
              ),
              validator: (val) {
                if (val != null && val.trim().isNotEmpty) {
                  final num = double.tryParse(val.trim());
                  if (num == null) return 'Please enter a valid amount';
                }
                return null;
              },
              onSaved: (val) => _creditLimit = val != null && val.trim().isNotEmpty ? double.parse(val.trim()) : 5000.0,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isEdit ? 'Save Changes' : 'Register Pharmacy',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
