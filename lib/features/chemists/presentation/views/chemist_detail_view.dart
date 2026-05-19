import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';
import 'package:medrep_pro/features/chemists/presentation/providers/chemist_providers.dart';

class ChemistDetailView extends ConsumerWidget {
  final Chemist chemist;

  const ChemistDetailView({super.key, required this.chemist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasBalanceWarning = chemist.outstandingBalance > chemist.creditLimit * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text(chemist.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/chemist-form', extra: chemist),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Chemist'),
                  content: const Text('Are you sure you want to delete this pharmacy profile? This deletion will sync offline.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(chemistListProvider.notifier).deleteChemist(chemist.id);
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
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.local_pharmacy, size: 40, color: Colors.blue),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chemist.name,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Contact: ${chemist.contactPerson ?? "Not provided"}',
                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text('Priority: ${chemist.priorityTag}'),
                            backgroundColor: Colors.blue.shade50,
                            labelStyle: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Credit & Outstanding Ledger',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: hasBalanceWarning ? Colors.red.shade50 : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: hasBalanceWarning ? Colors.red.shade200 : Colors.green.shade200,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Outstanding Balance',
                          style: TextStyle(
                            color: hasBalanceWarning ? Colors.red.shade800 : Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${chemist.outstandingBalance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: hasBalanceWarning ? Colors.red.shade900 : Colors.green.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Credit Limit',
                          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${chemist.creditLimit.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Location Details',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blue),
              title: const Text('Store Address'),
              subtitle: Text(chemist.address),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text('Store Phone'),
              subtitle: Text(chemist.phone ?? 'Not provided'),
            ),
            if (chemist.latitude != null && chemist.longitude != null)
              ListTile(
                leading: const Icon(Icons.gps_fixed, color: Colors.blue),
                title: const Text('GPS Geolocation'),
                subtitle: Text('Latitude: ${chemist.latitude}, Longitude: ${chemist.longitude}'),
              ),
          ],
        ),
      ),
    );
  }
}
