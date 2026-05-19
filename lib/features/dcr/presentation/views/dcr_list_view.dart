import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medrep_pro/features/dcr/presentation/providers/dcr_providers.dart';

class DcrListView extends ConsumerWidget {
  const DcrListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dcrListAsync = ref.watch(dcrListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DCR Logs'),
      ),
      body: dcrListAsync.when(
        data: (dcrs) {
          if (dcrs.isEmpty) {
            return const Center(
              child: Text('No DCRs found. Start logging today!'),
            );
          }
          return ListView.builder(
            itemCount: dcrs.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final dcr = dcrs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    'DCR for ${dcr.date.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Status: ${dcr.status.toUpperCase()}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to daily view or readonly detail based on status
                    context.push('/dcr-daily', extra: dcr);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading DCRs: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Today\'s DCR'),
        onPressed: () {
          context.push('/dcr-daily');
        },
      ),
    );
  }
}
